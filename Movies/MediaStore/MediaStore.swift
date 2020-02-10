//
//  MediaStore.swift
//  Movies
//
//  Created by Murtuza Saify on 2/9/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

protocol MediaStore {

    func mediaFor(filePath: String, completion: @escaping (Data?, Error?) -> ())
}

class DefaultMediaStore: MediaStore {

    private struct Constants {
        static let baseURL = "https://image.tmdb.org/t/p/"
        static let defaultSize = "w342"
    }
    
    func mediaFor(filePath: String, completion: @escaping (Data?, Error?) -> ()) {

        let urlString = Constants.baseURL + Constants.defaultSize + filePath
        guard let url = URL(string: urlString) else {
            return
        }

        if let existingData = UserDefaults.standard.object(forKey: urlString) as? Data {
            completion(existingData, nil)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let mediaData = try? Data(contentsOf: url)

            if let mediaData = mediaData {
                DispatchQueue.main.async {
                    completion(mediaData, nil)
                    UserDefaults.standard.set(mediaData, forKey: urlString)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            }
        }
    }
}
