//
//  HomeScreenViewModelTests.swift
//  SuperSmashBrosStatsTests
//
//  Created by Kamaal Farah on 20/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import XCTest
@testable import SuperSmashBrosStats

class HomeScreenViewModelTests: XCTestCase {

    var viewModel: HomeScreenViewModel?

    override func setUpWithError() throws {
        self.viewModel = HomeScreenViewModel(networker: MockNetworker())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testIfCharactersGetFilled() throws {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssert(viewModel.characters.isEmpty)
        XCTAssert(viewModel.loadingCharacters)
        viewModel.populateCharacters(cachedImages: [])
        var exception = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { exception = true }
        let fillCharacterExpection = self.expectation(description: "wait for the characters to fill")
        DispatchQueue(label: "fill-characters", qos: .background).async {
            while !exception {
                autoreleasepool {
                    if !viewModel.characters.isEmpty {
                        exception = true
                        fillCharacterExpection.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertFalse(viewModel.characters.isEmpty)
        XCTAssertFalse(viewModel.loadingCharacters)
    }

    func testIfSearchBarFilters() throws {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssertFalse(viewModel.showFavoritesOnly)
        viewModel.populateCharacters(cachedImages: [])
        var exception = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { exception = true }
        let fillCharacterExpection = self.expectation(description: "wait for the characters to fill")
        DispatchQueue(label: "fill-characters", qos: .background).async {
            while !exception {
                autoreleasepool {
                    if !viewModel.characters.isEmpty {
                        exception = true
                        fillCharacterExpection.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(viewModel.searchBarText.isEmpty)
        var filteredCharacters = viewModel.filteredCharacters(favoritedCharacters: [])
        XCTAssert(filteredCharacters.count > 20)
        XCTAssertEqual(filteredCharacters.count, viewModel.characters.count)
        viewModel.searchBarText.append(contentsOf: "y    o   u  n  g")
        filteredCharacters = viewModel.filteredCharacters(favoritedCharacters: [])
        XCTAssertEqual(filteredCharacters.count, 1)
        guard let firstCharacter = filteredCharacters.first
            else { return XCTFail("Failed to get first character in filtered characters") }
        XCTAssertEqual(firstCharacter.details.displayName, "Young Link")
        viewModel.showFavoritesOnly = true
        filteredCharacters = viewModel.filteredCharacters(favoritedCharacters: [])
        XCTAssert(filteredCharacters.isEmpty)
        viewModel.clearSearchBarText()
        XCTAssert(viewModel.searchBarText.isEmpty)
        filteredCharacters = viewModel.filteredCharacters(favoritedCharacters: [])
        XCTAssert(filteredCharacters.isEmpty)
        viewModel.showFavoritesOnly = false
        filteredCharacters = viewModel.filteredCharacters(favoritedCharacters: [])
        XCTAssert(filteredCharacters.count > 20)
        XCTAssertEqual(filteredCharacters.count, viewModel.characters.count)
    }

//    func testPerformanceExample() throws {
//        self.measure {
//        }
//    }

}
