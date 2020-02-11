//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import XCTest
@testable import Movies

class SearchMoviesTests: XCTestCase {

    var searchMovieListWorker: SearchMovieListUseCase?
    var movies: [Movie] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        searchMovieListWorker = SearchMovieListWorker()

        var m1 = Movie()
        m1.id = 1
        m1.title = "Sample Movie 1"

        var m2 = Movie()
        m1.id = 2
        m2.title = "Sample Movie 2"

        var m3 = Movie()
        m3.id = 1
        m3.title = "Test Movie 3"
        movies = [m1, m2, m3]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        searchMovieListWorker = nil
    }

    func testSearchMoviesIsFunctioningAsExpected() {
        guard let searchMovieListWorker = searchMovieListWorker else {
            fatalError("searchMovieListWorker should be initialized at this time.")
        }
        let searchResult = searchMovieListWorker.searchMovieFor(searchTerm: "Sample", from: movies)
        XCTAssert(searchResult.count == 2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
