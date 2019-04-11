//
//  DecisionTreeTest.swift
//  AIDevLogTests
//
//  Created by developer on 4/11/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import XCTest
@testable import AIDevLog

class DecisionTreeTest: XCTestCase {
    let X = [[1, 1],
        [1, 1],
        [1, 0],
        [0, 1],
        [0, 1]]
    let y = ["yes", "yes", "yes", "no", "no"]

    var tree: DecisionTree<Int, String>! = nil
    let features = [" no surfacing", "flippers"]

    override func setUp() {
        tree = DecisionTree<Int, String>()
        tree.fit(X: X, y: y)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnt() {
        let tree = DecisionTree<Int, String>()
        tree.fit(X: X, y: y)
        let ent = tree.calcShannonEnt(dataSet: X)
        XCTAssertEqual(ent, 0.9709505944546686)
    }

    func testSplitDataSet() {
        let dataSet1 = tree.splitDataSet(dataSet: X, col: 0, value: 1)
        print(dataSet1)
        XCTAssertTrue(dataSet1 == [[1], [1], [0]])
        let dataSet2 = tree.splitDataSet(dataSet: X, col: 0, value: 0)
        print(dataSet2)
        XCTAssertTrue(dataSet2 == [[1], [1]])
    }

    func testBestFeature() {
        let bestFeature = tree.chooseBestFeatureToSplit(dataSet: X)
        XCTAssertEqual(bestFeature, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
