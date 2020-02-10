//
//  APIManager.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

struct APIConstants {
    static let apiVersion = "3"
    static let baseURLString = "https://api.themoviedb.org/\(apiVersion)"
    static let apiKey = "7dc35bd813ac8849898436f8bb8ec2cb"
}

// Protocol APIManager to be confirmed by all API managers in app for ex: MovieAPIManager
protocol APIManager: class {

    var urlSession: URLSession? { get set }
    func execute<T: Decodable>(request: URLRequest, completion: @escaping (_ response: URLResponse?, _ object: T?, _ error: Error?)->())
}

extension APIManager {

    // method using generics + decodable to fetch and auto decode data.
    func execute<T: Decodable>(request: URLRequest, completion: @escaping (_ response: URLResponse?, _ object: T?, _ error: Error?)->()) {
        let dataTask = urlSession?.dataTask(with: request) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(response, nil, error)
                    }
                    return
                }
                let object = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(response, object, error)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(response, nil, error)
                }
            }
        }
        dataTask?.resume()
    }
}
