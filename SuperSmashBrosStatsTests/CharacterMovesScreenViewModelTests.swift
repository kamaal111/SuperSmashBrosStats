//
//  CharacterMovesScreenViewModelTests.swift
//  SuperSmashBrosStatsTests
//
//  Created by Kamaal Farah on 18/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import XCTest
@testable import SuperSmashBrosStats

class CharacterMovesScreenViewModelTests: XCTestCase {

    var viewModel: CharacterMovesScreenViewModel?
    let character = ultimateCharactersData[0]
    let responderHolder = ResponderHolder.shared

    override func setUpWithError() throws {
        self.responderHolder.reset()
        let character = Character(
            id: self.character.id,
            details: self.character,
            cachedThumbnailUrl: nil)
        self.viewModel = CharacterMovesScreenViewModel(character: character, networker: MockNetworker())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testIfViewModelFills() throws {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssert(viewModel.characterMoves.isEmpty)
        viewModel.populateCharacterMoves()
        var exception = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { exception = true }
        let fillCharacterMovesExpection = self.expectation(description: "wait for the characterMoves to fill")
        var times = 0
        let start: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
        DispatchQueue(label: "fill-moves", qos: .background).async {
            while !exception {
                autoreleasepool {
                    times += 1
                    if !viewModel.characterMoves.isEmpty {
                        exception = true
                        fillCharacterMovesExpection.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("Took \(diff) seconds") // Just for fun
        print("Times \(times) looped") // Just for fun
        XCTAssertFalse(viewModel.characterMoves.isEmpty)
        XCTAssertFalse(viewModel.categorizedCharacterMoves.isEmpty)
    }

//    func testPerformanceExample() throws {
//        self.measure {
//        }
//    }

}
