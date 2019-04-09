//
//  KMeansViewController.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class KMeansViewController: UIViewController {

    let imagesNamed = ["OvalSelected", "RectangleSelected", "TriangleSelected"]
    let radius: CGFloat = 5

    public var k: Int = 3
    public var maxIteration: Int = 30
    public var X: [CGPoint] = []
    public var y: [Int] = []
    public var XTest: [CGPoint] = []
    public var yTest: [Int] = []

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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var panelView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        model = KMeans(k: 3, maxIteration: maxIteration)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first {
            let position = touch.location(in: panelView)
            switch mlStep {
            case .train:
                drawIn(position)
                break
            default:
                drawIn(position)
                break
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
