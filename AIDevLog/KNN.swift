//
//  KNN.swift
//  AIDevLog
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

/// KNN
public class KNN<Feature, Label: Hashable> {
    
    /// Number of neighbors to use by default for :meth:`kneighbors` queries
    private var k: Int
    /// Data set
    private var X = [Feature]()
    /// Target values
    private var y = [Label]()
    
    /// distance
    private let distanceMetric: (_ x1: Feature, _ x2: Feature) -> Double
    /// draw radius for debug
    public var debugRadiusCallback: (([Double]) -> ())? = nil
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - k: k
    ///   - distanceMetric: distance
    public init (k: Int, distanceMetric: @escaping (_ x1: Feature, _ x2: Feature) -> Double) {
        assert(k > 0, "Error, k must be greater then 0.")
        self.k = k
        self.distanceMetric = distanceMetric
    }
    
    /// train
    ///
    /// - Parameters:
    ///   - X: Training set
    ///   - y: Target values
    public func fit(X: [Feature], y: [Label]) {
        assert(X.count == y.count, "Length of Data not equal to length of Labels \(X.count) != \(y.count)")
        assert(k <= X.count, "Number of neighbors is less than total number of points")
        self.X = X
        self.y = y
    }
    
    
    /// Labels for xTest
    ///
    /// - Parameter XTest: Test set
    /// - Returns: Target values
    public func predict(XTest: [Feature]) -> [Label] {
        assert(X.count > 0, "Please, use method train() at first to provide training data.")
        
        var labels = [Label]()
        var radiuses = [Double]()
        for xTest in XTest {
            let tuples = zip(X, y)
                .map { (distanceMetric(xTest, $0.0), $0.1) }    // calculate tuples (distance, label)
                .sorted { $0.0 < $1.0 }                     // sort descending by distances
                .prefix(upTo: k)                            // take first k elements
            radiuses.append(tuples.last!.0)
            let countedSet = NSCountedSet(array: tuples.map{$0.1})
            
            // sort ascending by frequency
            let label = countedSet.allObjects.sorted {
                countedSet.count(for: $0) > countedSet.count(for: $1)
                }.first! as! Label
            labels.append(label)
        }
        self.debugRadiusCallback?(radiuses)
        
        return labels
    }
}
