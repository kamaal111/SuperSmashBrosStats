//
//  TopListerTests.swift
//  SuperSmashBrosStatsTests
//
//  Created by Kamaal Farah on 16/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import XCTest
@testable import SuperSmashBrosStats

class TopListerTests: XCTestCase {

    var topLister = TopLister.shared

    override func setUpWithError() throws {
        self.topLister.resetData()
    }

    override func tearDownWithError() throws { }

    func testIfTopListGetPopulated() throws {
        let getWeightEROfUltimateTopListItems = self.topLister.getTopListItems(of: "WeightER", game: "ultimate")
        XCTAssertTrue(getWeightEROfUltimateTopListItems.isEmpty)
        let getWeightOfUltimatumTopListItems = self.topLister.getTopListItems(of: "Weight", game: "ultimatum")
        XCTAssertTrue(getWeightOfUltimatumTopListItems.isEmpty)
        let getWeightOfUltimateTopListItems = self.topLister.getTopListItems(of: "Weight", game: "ultimate")
        XCTAssertFalse(getWeightOfUltimateTopListItems.isEmpty)
    }

    func testWeightClass() {
        let topList = self.topLister.getTopListItems(of: "Weight", game: "ultimate")
        guard let key = topList.keys.first,
            let weightClass = topList[key],
            let firstInWeightClass = weightClass.first,
            let lastInWeightClass = weightClass.last else { return XCTFail("Failed to unwrap values") }
        XCTAssertEqual(firstInWeightClass.owner, "Bowser")
        XCTAssertEqual(lastInWeightClass.owner, "Pichu")
        self.topLister.setSortingMethod(to: .ascending)
        let reversedTopList = self.topLister.getTopListItems(of: "Weight", game: "ultimate")
        guard let reversedWeightClass = reversedTopList[key],
            let firstInReversedWeightClass = reversedWeightClass.first,
            let lastInReversedWeightClass = reversedWeightClass.last else { return XCTFail("Failed to unwrap values") }
        XCTAssertEqual(firstInReversedWeightClass.owner, "Pichu")
        XCTAssertEqual(lastInReversedWeightClass.owner, "Bowser")
    }

//    func testPerformanceExample() throws {
//        self.measure {
//        }
//    }

}
