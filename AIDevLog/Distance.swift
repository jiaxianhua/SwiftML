//
//  Distance.swift
//  AIDevLog
//
//  Created by iosdevlog on 2019/4/7.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

public struct Distance {

    /// Helper function to calculate euclidian distance
    ///
    /// - Parameters:
    ///   - x0: source coordinate
    ///   - x1: target coordinate
    /// - Returns: euclidian distance
    public static func euclideanDistance(_ x0: [Double], _ x1: [Double]) -> Double {
        guard x0.count == x1.count else {
            fatalError("Features' lengths are not equal")
        }

        // Calculate euclidean distances sqrt((x1 - x0)^2 + (y1 - y0)^2)
        let euclideanDistance = sqrt(
            zip(x0, x1)
                .map({ pow($0 - $1, 2) })
                .reduce(0, +)
        )

        return Double(euclideanDistance)
    }

    // Convenience
    public static func euclideanDistance() -> (([Double], [Double]) -> Double) {
        return { self.euclideanDistance($0, $1) }
    }
    
    public static func euclideanDistance() -> ((CGPoint, CGPoint) -> Double) {
        return { $0.distanceTo($1) }
    }
}
