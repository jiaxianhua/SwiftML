//
//  KMeans.swift
//  AIDevLog
//
//  Created by iosdevlog on 2019/4/8.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

/// K-Means clustering.
public class KMeans<Feature: FeatureProtocol> {

    /// The number of clusters to form as well as the number of centroids to generate.
    let k: Int

    /// Labels of each point
    let y: [Int]

    /// Maximum number of iterations of the k-means algorithm for a single run.
    let maxIteration: Int

    /// Sum of squared distances of samples to their closest cluster center.
    private(set) var centroids = [Feature]()

    /// Constructor.
    ///
    /// - Parameters:
    ///   - k: The number of clusters.
    ///   - maxIteration: max Iteration.
    init(k: Int = 3, maxIteration: Int = 30) {
        self.k = k
        self.y = (0..<k).map { $0 }
        self.maxIteration = maxIteration
    }


    /// index Of Nearest Center.
    ///
    /// - Parameters:
    ///   - x: current sample.
    ///   - centers: centers.
    /// - Returns: index Of Nearest Center.
    private func indexOfNearestCenter(_ x: Feature, centers: [Feature]) -> Int {
        var nearestDist = Double.greatestFiniteMagnitude
        var minIndex = 0

        for (idx, center) in centers.enumerated() {
            let dist = x.distanceTo(center)
            if dist < nearestDist {
                minIndex = idx
                nearestDist = dist
            }
        }

        return minIndex
    }

    /// Compute k-means clustering.
    ///
    /// - Parameters:
    ///   - points: array-like.
    ///   - convergeDistance: the sum of distance.
    func fit(_ X: [Feature], convergeDistance: Double = 0) {
        // Randomly take k objects from the input data to make the initial centroids.
        var centers = pickerSamples(X, k: k)

        var centerMoveDist = 0.0

        for _ in 0..<maxIteration {
            // This array keeps track of which data points belong to which centroids.
            var kClusters: [[Feature]] = Array(repeating: [], count: k)

            // For each data point, find the centroid that it is closest to.
            for p in X {
                let classIndex = indexOfNearestCenter(p, centers: centers)
                kClusters[classIndex].append(p)
            }

            // Take the average of all the data points that belong to each centroid.
            // This moves the centroid to a new position.
            let newCenters = kClusters.map { sample -> Feature in
                Feature.mean(sample)
            }

            // Find out how far each centroid moved since the last iteration. If it's
            // only a small distance, then we're done.
            centerMoveDist = 0.0
            for idx in 0..<k {
                centerMoveDist += centers[idx].distanceTo(newCenters[idx])
            }

            centers = newCenters

            if centerMoveDist > convergeDistance {
                break
            }
        }

        centroids = centers
    }

    private func predict(_ xTest: Feature) -> Int {
        assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

        let centroidIndex = indexOfNearestCenter(xTest, centers: centroids)
        return y[centroidIndex]
    }

    func predict(_ XTest: [Feature]) -> [Int] {
        assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

        return XTest.map(predict)
    }
}

// Pick k random elements from samples.
func pickerSamples<T>(_ samples: [T], k: Int) -> [T] {
    var result = [T]()

    // Fill the result array with first k elements.
    for i in 0..<k {
        result.append(samples[i])
    }

    // Randomly replace elements from remaining pool.
    for i in k..<samples.count {
        let j = Int(arc4random_uniform(UInt32(i + 1)))

        if j < k {
            result[j] = samples[i]
        }
    }
    return result
}
