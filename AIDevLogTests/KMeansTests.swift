//
//  KMeansTests.swift
//  AIDevLogTests
//
//  Created by iosdevlog on 2019/4/9.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import XCTest
import ARKit
@testable import AIDevLog

class KMeansTests: XCTestCase {
    func generalArray(_ numPoints: Int, numDimensions: Int) -> [[Double]] {
        var points = [[Double]]()
        for _ in 0..<numPoints {
            var data = [Double]()
            for _ in 0..<numDimensions {
                data.append(Double(arc4random_uniform(UInt32(numPoints * numDimensions))))
            }
            points.append([Double](data))
        }
        return points
    }

    func generalPoints(_ numPoints: Int) -> [CGPoint] {
        var points = [CGPoint]()
        for _ in 0..<numPoints {
            let point = CGPoint(x: CGFloat(arc4random_uniform(320)), y: CGFloat(arc4random_uniform(320)))
            points.append(point)
        }
        return points
    }

    func generalVectors(_ numPoints: Int) -> [SCNVector3] {
        var points = [SCNVector3]()
        for _ in 0..<numPoints {
            let point = SCNVector3(x: Float(arc4random_uniform(10000)) / Float(10000.0), y: Float(arc4random_uniform(10000)) / Float(10000.0), z: Float(arc4random_uniform(10000)) / Float(10000.0))
            points.append(point)
        }
        return points
    }

    func testSmallPoints() {
        let points = generalPoints(10)

        print("\nCenters")
        let kMeans = KMeans<CGPoint>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testSmallVectors() {
        let points = generalVectors(10)

        print("\nCenters")
        let kMeans = KMeans<SCNVector3>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testSmall_2D() {
        let points = generalArray(10, numDimensions: 2)

        print("\nCenters")
        let kMeans = KMeans<[Double]>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testSmall_10D() {
        let points = generalArray(10, numDimensions: 10)

        print("\nCenters")
        let kMeans = KMeans<[Double]>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testLarge_2D() {
        let points = generalArray(10000, numDimensions: 2)

        print("\nCenters")
        let kMeans = KMeans<[Double]>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testLarge_10D() {
        let points = generalArray(10000, numDimensions: 10)

        print("\nCenters")
        let kMeans = KMeans<[Double]>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

    func testLargePoint() {
        let points = generalArray(10000, numDimensions: 10)

        print("\nCenters")
        let kMeans = KMeans<[Double]>(k: 3, maxIteration: 30)
        kMeans.fit(points, convergeDistance: 0.01)

        for (label, centroid) in zip(kMeans.y, kMeans.centroids) {
            print("\(label): \(centroid)")
        }

        print("\nClassifications")
        for (label, point) in zip(kMeans.predict(points), points) {
            print("\(label): \(point)")
        }
    }

}
