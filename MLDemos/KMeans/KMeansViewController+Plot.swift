//
//  KMeansViewController+Plot.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

extension KMeansViewController {
    fileprivate func flowerLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let width: CGFloat = radius
        let height: CGFloat = width

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: position.x, y: position.y,
            width: width, height: height)

        let path = CGMutablePath()

        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 3).forEach {
            angle in
            var transform = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))

            let petal = CGPath(ellipseIn: CGRect(x: -width, y: 0, width: width, height: height),
                transform: &transform)

            path.addPath(petal)
        }

        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shapeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha).cgColor

        panelView.layer.addSublayer(shapeLayer)
        trainLayer.append(shapeLayer)
    }

    fileprivate func circleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
        shapeLayer.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: alpha).cgColor
        panelView.layer.addSublayer(shapeLayer)
        trainLayer.append(shapeLayer)
    }

    fileprivate func rectangleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
        shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: alpha).cgColor
        panelView.layer.addSublayer(shapeLayer)
        predictLayer.append(shapeLayer)
    }

    fileprivate func triangleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let layer = CAShapeLayer()
        layer.position = position
        layer.contents = UIImage(named: "triangleLayer")?.image(alpha: alpha)?.cgImage
        layer.contentsGravity = CALayerContentsGravity.center

        panelView.layer.addSublayer(layer)
        trainLayer.append(layer)
    }

    func drawPredictCluster() {
        for (index, shapeLayer) in predictLayer.enumerated() {
            let position = XTest[index]
            let label = yTest[index]

            switch label {
            case 0:
                shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
                shapeLayer.fillColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 0.8).cgColor
                break
            case 1:
                shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 0.8).cgColor
                break
            case 2:
                shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 0.8).cgColor
                break
            default:
                shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8).cgColor
                break
            }
        }
    }

    func drawTrainCluster() {
        for (index, shapeLayer) in trainLayer.enumerated() {
            let position = X[index]
            let label = y[index]

            switch label {
            case 0:
                shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
                shapeLayer.fillColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1).cgColor
                break
            case 1: shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1).cgColor
                break
            case 2: shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1).cgColor
                break
            default: shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
                shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
                break
            }
        }
    }

    func drawIn(_ position: CGPoint) {
        switch mlStep {
        case .train:
            X.append(position)
            circleLayer(position)
            break
        case .predict:
            XTest.append(position)

            rectangleLayer(position)
            break
        }
    }

    
    func drawCenter(center: CGPoint, label: Int, alpha: CGFloat = 1) {
        var color = UIColor.red
        switch label {
        case 0:
            color = .black
        case 1:
            color = .cyan
        case 2:
            color = .yellow
        case 3:
            color = .yellow
        default:
            color = .black
            break
        }
        let shapeLayer = CAShapeLayer()
        centerRadius += 0.3
        shapeLayer.path = UIBezierPath(rect: CGRect(x: center.x - centerRadius, y: center.y - centerRadius, width: centerRadius * 2, height: centerRadius * 2)).cgPath
        shapeLayer.fillColor = color.cgColor
//        shapeLayer.borderColor = color.cgColor
        shapeLayer.borderWidth = 0.1
        panelView.layer.addSublayer(shapeLayer)
    }
}
