//
//  DecisionTree.swift
//  AIDevLog
//
//  Created by developer on 4/11/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation


public class DecisionTree<Value: Hashable, Label: Hashable> {
    typealias Feature = [Value]
    /// Data set
    private var X = [Feature]()
    /// Target values
    private var y = [Label]()

    func fit(X: [Feature], y: [Label]) {
        self.X = X
        self.y = y
    }

    func predict(X: [Feature]) {

    }

    func calcShannonEnt(dataSet: [Feature]) -> Double {
        let numEntires = dataSet.count
        var labelCounts = [Label: Int]()

        y.forEach { labelCounts[$0] = labelCounts[$0, default: 0] + 1 }
        var shannonEnt = 0.0
        labelCounts.forEach {
            let prob = Double($0.value) / Double(numEntires)
            shannonEnt -= prob * log2(prob)
        }

        return shannonEnt
    }

    func splitDataSet(dataSet: [Feature], col: Int, value: Value) -> [Feature] {
        var dataset = [Feature]()

        for x in X {
            if x[col] == value {
                let subData = Array(x[0..<col] + x[col + 1..<x.count])
                dataset.append(subData)
            }
        }

        return dataset
    }

    func chooseBestFeatureToSplit(dataSet: [Feature]) -> Int {
        let featuresNum = dataSet[0].count
        let baseEntropy = calcShannonEnt(dataSet: X)
        var bestInfoGain = 0.0
        var bestFeature = -1

        for i in 0..<featuresNum {
            let values = X.map { $0[i] }
            let uniqValues = Set(values)
            var newEntropy = 0.0

            for value in uniqValues {
                let subDataset = splitDataSet(dataSet: dataSet, col: i, value: value)
                let prob = Double(subDataset.count) / Double(dataSet.count)
                newEntropy += prob * calcShannonEnt(dataSet: subDataset)
            }

            let infoGain = baseEntropy - newEntropy
            print("第 \(i) 个特征的增益为 \(infoGain)")
            if infoGain > bestInfoGain {
                bestInfoGain = infoGain
                bestFeature = i
            }
        }

        return bestFeature
    }
}
