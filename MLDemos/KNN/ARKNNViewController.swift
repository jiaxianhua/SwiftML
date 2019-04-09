//
//  ARKNNViewController.swift
//  ARML
//
//  Created by iosdevlog on 2019/4/7.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AIDevLog

class ARKNNViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var geometrySegmentControl: UISegmentedControl!

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var kButton: UIButton!
    let radius: CGFloat = 0.05

    public var X: [[Double]] = []
    public var y: [Geometry3DType] = []
    public var XTest: [[Double]] = []
    public var yTest: [Geometry3DType] = []
    public var radiuses: [Double] = [] {
        didSet {
            for (center, r) in zip(XTest, radiuses) {
                drawSphere(center: SCNVector3(x: Float(center[0]), y: Float(center[1]), z: Float(center[2])), radius: Float(r))
            }
        }
    }

    func drawSphere(center: SCNVector3, radius: Float) {
        let geometry = SCNSphere(radius: CGFloat(radius) + self.radius)
  
        geometry.firstMaterial?.diffuse.contents = UIColor(red: 0.1, green: 0.1, blue: 0.8, alpha: 0.7)
        
        let node = SCNNode()
        node.geometry = geometry
        node.position = center
        sceneView.scene.rootNode.addChildNode(node)
    }

    @IBOutlet weak var trainButton: UIButton!
    var model = KNN<[Double], Geometry3DType>(k: 1, distanceMetric: Distance.euclideanDistance())

    var mlStep = MLStep.train {
        didSet {
            switch mlStep {
            case .train:
                trainButton.setTitle("train", for: .normal)
            default:
                trainButton.setTitle("predict", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        sceneView.autoenablesDefaultLighting = true

        tableView.isHidden = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 30

        addTapGestureToSceneView()
        reset()
    }

    @IBAction func reset() {
        mlStep = .train
        X.removeAll()
        y.removeAll()
        XTest.removeAll()
        yTest.removeAll()
        
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration, options: .resetTracking)
        
        model.debugRadiusCallback = { [weak self] radiuses in
            self?.radiuses = radiuses
        }
        
        for node in sceneView.scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
    }

    @IBAction func clearTest() {
        XTest.removeAll()
        yTest.removeAll()
    }

    @IBAction func train() {
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
    
    func drawPredict() {
        _ = zip(XTest, yTest).map({ (sample_X, sample_y) in
            let position = SCNVector3(sample_X[0], sample_X[1], sample_X[2])
            let geometryType = sample_y
            
            var node = SCNNode()
            switch geometryType {
            case .box:
                node = createBox()
                break
            case .pyramid:
                node = createPyramid()
                break
            case .sphere:
                node = createSphere()
                break
            case .cylinder:
                node = createCylinder()
                break
            case .cone:
                node = createCone()
                break
            case .tube:
                node = createTube()
                break
            case .torus:
                node = createTorus()
                break
            default:
                break
            }
            node.position = position
            sceneView.scene.rootNode.addChildNode(node)
        })
    }

    @IBAction func selectK() {
        self.tableView.isHidden = !self.tableView.isHidden
    }

    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let sceneView = recognizer.view as! ARSCNView

        if let transform = self.sceneView.session.currentFrame?.camera.transform {
            let mat = SCNMatrix4(transform);

            let position = SCNVector3Make(mat.m41, mat.m42, mat.m43);

            switch mlStep {
            case .train:
                var node = SCNNode()
                let geometry = Geometry3DType(rawValue: geometrySegmentControl.selectedSegmentIndex)!
                switch geometry {
                case .box:
                    node = createBox()
                    break
                case .pyramid:
                    node = createPyramid()
                    break
                case .sphere:
                    node = createSphere()
                    break
                case .cylinder:
                    node = createCylinder()
                    break
                case .cone:
                    node = createCone()
                    break
                case .tube:
                    node = createTube()
                    break
                case .torus:
                    node = createTorus()
                    break
                default:
                    break
                }
                
                node.position = position
                sceneView.scene.rootNode.addChildNode(node)
                X.append([Double(position.x), Double(position.y), Double(position.z)])
                y.append(geometry)
                break
            default:
                drawIn(position, geometryType: .__totalCount)
                XTest.append([Double(position.x), Double(position.y), Double(position.z)])
                break
            }
        }
    }
    
    func drawIn(_ position: SCNVector3, geometryType: Geometry3DType) {
        let geometry = SCNSphere(radius: radius/4)
        let node = SCNNode()
        node.geometry = geometry
        node.position = position
        sceneView.scene.rootNode.addChildNode(node)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}
