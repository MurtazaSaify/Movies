//
//  FetchOfflineMovieListInteractor.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

// Worker to fetch and save data to User defaults to support offline mode
class OfflineMovieListWorker: FetchMovieListUseCase {

    private struct Constants {
        static let cacheKeyPrefix = "cache_"
    }
    
    func fetchMovies(criteria: MovieFetchCriteria, page: Int, completion: ((MovieCollection?, Error?) -> ())) {
        let cacheKey = Constants.cacheKeyPrefix + criteria.rawValue

        guard let savedEncodedCollection = UserDefaults.standard.object(forKey: cacheKey) as? Data else {
            completion(nil, nil)
            return
        }
        
        let decoder = JSONDecoder()
        guard let collection = try? decoder.decode(MovieCollection.self, from: savedEncodedCollection) else {
            completion(nil, nil)
            return
        }
        completion(collection, nil)
    }
}

extension OfflineMovieListWorker: CacheMovieListUseCase {

    func cache(movieCollection: MovieCollection, criteria: MovieFetchCriteria) {
        let cacheKey = Constants.cacheKeyPrefix + criteria.rawValue
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieCollection) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: cacheKey)
        }
    }
}
