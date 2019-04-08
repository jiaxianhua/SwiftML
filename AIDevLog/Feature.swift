//
//  Feature.swift
//  AIDevLog
//
//  Created by iosdevlog on 2019/4/8.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import ARKit

/// FeatureProtocol
public protocol FeatureProtocol {
    /// distance
    ///
    /// - Parameter o: other
    /// - Returns: distance between self and other
    func distanceTo(_ o: Self) -> Double

    /// mean
    ///
    /// - Parameter items: items should be Calculation
    /// - Returns: mean of items
    static func mean(_ items: [Self]) -> Self
}

// MARK: - FeatureProtocol where Element == Double
extension Array: FeatureProtocol where Element == Double {
    public static func mean(_ items: [Array<Element>]) -> Array<Element> {
        let zeroArray = [Double](repeating: 0, count: items.count)
        return items.reduce(zeroArray, +).map { $0 / Double(items.count) }
    }

    public func distanceTo(_ o: Array<Element>) -> Double {
        guard self.count == o.count else {
            fatalError("Features' lengths are not equal")
        }

        let euclideanDistance = sqrt(
            zip(self, o)
                .map({ pow($0 - $1, 2) })
                .reduce(0, +)
        )

        return euclideanDistance
    }
}

extension CGPoint: FeatureProtocol {
    public func distanceTo(_ o: CGPoint) -> Double {
        let square = Double(pow(o.x - self.x, 2)) + Double(pow(o.y - self.y, 2))
        return sqrt(square)
    }

    public static func mean(_ items: [CGPoint]) -> CGPoint {
        if items.count == 0 {
            return CGPoint(x: 0, y: 0)
        }

        var sumX = CGFloat(0)
        var sumY = CGFloat(0)

        for i in items {
            sumX += i.x
            sumY += i.y
        }

        let doubleCount = CGFloat(items.count)
        sumX /= doubleCount
        sumY /= doubleCount

        return CGPoint(x: sumX, y: sumY)
    }
}

extension SCNVector3: FeatureProtocol {
    public func distanceTo(_ o: SCNVector3) -> Double {
        let square = Double(pow(o.y - self.y, 2)) + Double(pow(o.y - self.y, 2)) + Double(pow(o.z - self.z, 2))
        return sqrt(square)
    }

    public static func mean(_ items: [SCNVector3]) -> SCNVector3 {
        if items.count == 0 {
            return SCNVector3(x: 0, y: 0, z: 0)
        }

        var sumX = Float(0)
        var sumY = Float(0)
        var sumZ = Float(0)

        for i in items {
            sumX += i.x
            sumY += i.y
            sumZ += i.z
        }

        let doubleCount = Float(items.count)
        sumX /= doubleCount
        sumY /= doubleCount
        sumZ /= doubleCount

        return SCNVector3(x: sumX, y: sumY, z: sumZ)
    }
}

struct Point: FeatureProtocol {
    let x: Double
    let y: Double

    func distanceTo(_ o: Point) -> Double {
        let aSquared: Double = (o.y - self.y) * (o.y - self.y)
        let bSquared: Double = (o.x - self.x) * (o.x - self.x)
        return sqrt(aSquared + bSquared) // Pythagoras 🥰
    }

    static func mean(_ items: [Point]) -> Point { // barycenter
        if items.count == 0 { // division by zero is bad news
            return Point(x: 0, y: 0)
        }

        var sumX = 0.0
        var sumY = 0.0

        for i in items {
            sumX += i.x
            sumY += i.y
        }

        let doubleCount = Double(items.count)
        sumX /= doubleCount
        sumY /= doubleCount

        return Point(x: sumX, y: sumY)
    }
}
