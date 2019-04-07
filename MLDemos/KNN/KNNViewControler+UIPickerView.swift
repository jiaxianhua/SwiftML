//
//  KNNViewControler+UIPickerView.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import AIDevLog

extension KNNViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 7
        default:
            return GeometryType.numberOfCases()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var componentTitle = ""
        switch component {
        case 0:
            let k = row + 1
            componentTitle = "\(k)"
            break
        default:
            componentTitle = GeometryType(rawValue: row)!.description
            break
        }

        return componentTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let k = row + 1
            model = KNN<[Double], GeometryType>(k: k, distanceMetric: Distance.euclideanDistance())
            reset()
        }
    }
}
