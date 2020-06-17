//
//  CharacterTopListViewModelTests.swift
//  SuperSmashBrosStatsTests
//
//  Created by Kamaal Farah on 16/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import XCTest
import Foundation
@testable import SuperSmashBrosStats

class CharacterTopListViewModelTests: XCTestCase {

    var viewModel: CharacterTopListViewModel?
    let attributes: [CodableCharacterAttributes] = SuperSmashBrosStats.load("characterAttributes-ultimate-2.json")
    let topLister = TopLister.shared

    override func setUpWithError() throws {
        self.viewModel = CharacterTopListViewModel(attributes: attributes[0])
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testIfViewModelPopulates() throws {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssertTrue(viewModel.topListItems.isEmpty)
        viewModel.populateTopListItems()
        XCTAssertFalse(viewModel.topListItems.isEmpty)
    }

    func testIfShowSortActionSheetToggles() {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssertFalse(viewModel.showSortActionSheet)
        viewModel.sortButtonAction()
        XCTAssertTrue(viewModel.showSortActionSheet)
    }

    func testIfSortingMethodGetsSet() {
        guard let viewModel = self.viewModel else { return XCTFail("Failed to load viewmodel") }
        XCTAssert(self.topLister.getSortingMethod() == .descending)
        XCTAssert(self.topLister.getSortingMethod() != .ascending)
        XCTAssert(self.topLister.getSortingMethod() != .defaultSort)
        viewModel.setSortingMethod(to: .ascending)
        XCTAssert(self.topLister.getSortingMethod() == .ascending)
        XCTAssert(self.topLister.getSortingMethod() != .descending)
        XCTAssert(self.topLister.getSortingMethod() != .defaultSort)
        viewModel.setSortingMethod(to: .defaultSort)
        XCTAssert(self.topLister.getSortingMethod() == .defaultSort)
        XCTAssert(self.topLister.getSortingMethod() != .descending)
        XCTAssert(self.topLister.getSortingMethod() != .ascending)
    }

//    func testPerformanceExample() throws {
//        measure {
//        }
//    }

}
