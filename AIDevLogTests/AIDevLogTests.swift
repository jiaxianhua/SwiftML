//
//  AIDevLogTests.swift
//  AIDevLogTests
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import XCTest
@testable import AIDevLog

class AIDevLogTests: XCTestCase {

    class TestEstimator: BaseEstimator {
        @objc var count: Int
        @objc var desc: String
        
        override init() {
            self.count = 0
            self.desc = "Hello AIDevLog"
            
            super.init()
        }
        
        init(count: Int, desc: String) {
            self.count = count
            self.desc = desc
            
            super.init()
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseEstimator() {
        let testEstimator = TestEstimator()
        testEstimator.setParams(params: ["count": 1, "desc": "Hello AIDevLog"])
        let str = testEstimator.getParams(deep: false)
        XCTAssertTrue(str.contains("Hello AIDevLog"))
    }
    
    func testKNN() {
        let kNN = KNN<Double, Int>(k: 3)
        let X = [[1.0], [2], [3], [4]]
        let y = [0, 0, 1, 1]
        kNN.fit(X, y)
        
        let label = kNN.predict([[1.2], [3]])
        
        XCTAssertEqual([0, 1], label)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
