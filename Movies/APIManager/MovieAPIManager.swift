//
//  MovieAPIManager.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

// MovieAPIManager protocol to have interface specific to movie endpoints.
protocol MovieAPIManager: APIManager {

    func fetchMovies(criteria: MovieFetchCriteria, page: Int, completion: @escaping (_ movieCollection: MovieCollection?, _ error: Error?) -> ())
    func fetchMovieDetailsFor(movieId: Int, completion:  @escaping (_ movie: Movie?, _ error: Error?) -> ())
}

class DefaultMovieAPIManager: MovieAPIManager {

    private enum Endpoint {
        case fetchMovies(criteria: MovieFetchCriteria, page: Int)
        case movieDetails(movieId: Int)

        func absoluteURL() -> URL? {
            var urlString: String
            switch self {
            case let .fetchMovies(criteria, page):
                urlString = "\(APIConstants.baseURLString)/movie/\(criteria.rawValue)?page=\(page)"
            case let .movieDetails(movieId):
                urlString = "\(APIConstants.baseURLString)/movie/\(movieId)"
            }
            var urlComponents = URLComponents(string: urlString)
            var queryItems = urlComponents?.queryItems ?? []
            queryItems.append(URLQueryItem(name: "api_key", value: APIConstants.apiKey))
            urlComponents?.queryItems = queryItems
            return urlComponents?.url
        }
    }

    var urlSession: URLSession?

    init() {
        self.urlSession = URLSession.shared
    }

    func fetchMovies(criteria: MovieFetchCriteria, page: Int, completion: @escaping (_ movieCollection: MovieCollection?, _ error: Error?) -> ()) {
        guard let url = Endpoint.fetchMovies(criteria: criteria, page: page).absoluteURL() else {
            return
        }
        let urlRequest = URLRequest(url: url)
        execute(request: urlRequest) { (response: URLResponse?, movies: MovieCollection?, error: Error?) in
            completion(movies, error)
        }
    }

    func fetchMovieDetailsFor(movieId: Int, completion:  @escaping (_ movie: Movie?, _ error: Error?) -> ()) {
        guard let url = Endpoint.movieDetails(movieId: movieId).absoluteURL() else {
            return
        }
        let urlRequest = URLRequest(url: url)
        execute(request: urlRequest) { (response: URLResponse?, movie: Movie?, error: Error?) in
            completion(movie, error)
        }
    }
}
