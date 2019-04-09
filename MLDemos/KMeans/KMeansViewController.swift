//
//  KMeansViewController.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class KMeansViewController: UIViewController {
    let radius: CGFloat = 5
    var centerRadius: CGFloat = 1.0

    var k: Int = 3
    var maxIteration: Int = 30
    var convergeDistance = 0.001
    var X: [CGPoint] = []
    var y: [Int] = []
    var XTest: [CGPoint] = []
    var yTest: [Int] = []
    var trainLayer = [CAShapeLayer]()
    var predictLayer = [CAShapeLayer]()
    var centers = [CGPoint]() {
        didSet {
            for (index, center) in centers.enumerated() {
                drawCenter(center: center, label: index)
            }
        }
    }

    var model: KMeans<CGPoint>!

    var mlStep = MLStep.train {
        didSet {
            switch mlStep {
            case .train:
                trainBarButtonItem.title = "train"
            default:
                trainBarButtonItem.title = "predict"
            }
        }
    }

    @IBOutlet weak var trainBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var panelView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        reset()
//            .title = String(describing: k)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first {
            let position = touch.location(in: panelView)
            drawIn(position)
        }
    }
    
    @IBAction func generalRamdom() {
        reset()
        X.append(contentsOf: generalPoints(1000))
        X.forEach{ drawIn($0) }
    }

    @IBAction func reset() {
        centerRadius = 1
        mlStep = .train
        X.removeAll()
        y.removeAll()
        XTest.removeAll()
        yTest.removeAll()
        trainLayer.removeAll()
        predictLayer.removeAll()
        if let subLayers = panelView.layer.sublayers {
            subLayers.forEach { $0.removeFromSuperlayer() }
        }
        
        model = KMeans<CGPoint>(k: k, maxIteration: maxIteration)
        model.debugCentroidsCallback = { [weak self] centers in
            self?.centers = centers
        }
        
    }

    @IBAction func train(_ sender: Any) {
        if mlStep == .train {
            model.fit(X, convergeDistance: convergeDistance)
            
            for (label, centroid) in zip(model.y, model.centroids) {
                print("\(label): \(centroid)")
            }
            
            y = model.predict(X)
            print("\nClassifications")
            for (feature, label) in zip(X, y) {
                print("\(label): \(feature)")
            }
            drawTrainCluster()
            mlStep = .predict
        } else {
            yTest = model.predict(XTest)
            print("\nyTest Classifications")
            for (feature, label) in zip(XTest, yTest) {
                print("\(label): \(feature)")
            }
            drawPredictCluster()
        }
    }

    @IBAction func setMaxIteration(_ sender: Any) {
    }

    @IBAction func setMinDistance(_ sender: Any) {
    }

    func generalPoints(_ numPoints: Int) -> [CGPoint] {
        var points = [CGPoint]()
        for _ in 0..<numPoints {
            let point = CGPoint(x: CGFloat(arc4random_uniform(UInt32(panelView.bounds.width))), y: CGFloat(arc4random_uniform(UInt32(panelView.bounds.height))))
            points.append(point)
        }
        return points
    }
}
