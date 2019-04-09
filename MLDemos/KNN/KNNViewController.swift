//
//  KNNViewController.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import AIDevLog
import ARKit

class KNNViewController: UIViewController {
    let imagesNamed = ["OvalSelected", "RectangleSelected", "TriangleSelected"]

    let radius: CGFloat = 5

    var k: Int = 1
    var X: [CGPoint] = []
    var y: [Geometry2DType] = []
    var XTest: [CGPoint] = []
    var yTest: [Geometry2DType] = []
    var radiuses: [Double] = [] {
        didSet {
            for (center, r) in zip(XTest, radiuses) {
                drawCircle(center: center, radius: CGFloat(r))
            }
        }
    }
    var currentType = Geometry2DType.circle
    public var predictLayers: [CALayer] = []
    var model = KNN<CGPoint, Geometry2DType>(k: 1, distanceMetric: Distance.euclideanDistance())

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var trainBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var kBarBtuuonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!

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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)

        tableView.dataSource = self
        tableView.delegate = self
        reset()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first {
            let position = touch.location(in: panelView)
            switch mlStep {
            case .train:
                drawIn(position, geometryType: currentType)
                break
            default:
                drawIn(position, geometryType: .__totalCount)
                break
            }
        }
    }

    @IBAction func train(_ sender: UIBarButtonItem) {
        switch mlStep {
        case .train:
            mlStep = .predict
            model.fit(X: X, y: y)
            break
        default:
            yTest = model.predict(XTest: XTest)

            drawPredict()
            break
        }
    }

    @IBAction func reset() {
        mlStep = .train
        X.removeAll()
        y.removeAll()
        XTest.removeAll()
        yTest.removeAll()
        
        cleanTest()

        model.debugRadiusCallback = { [weak self] radiuses in
            self?.radiuses = radiuses
        }
        
        trainBarButtonItem.title = String(describing: k)
        model = KNN(k: k, distanceMetric: Distance.euclideanDistance())
    }

    @IBAction func selectK(_ sender: UIBarButtonItem) {
        tableView.isHidden = !tableView.isHidden
    }
    
    @IBAction func cleanTest(_ sender: Any) {
        cleanTest()
    }
    
    // MARK: - Helper
    func cleanTest() {
        predictLayers.removeAll()
        
        if let subLayers = panelView.layer.sublayers {
            for layer in subLayers {
                layer.removeFromSuperlayer()
            }
        }
    }
}
