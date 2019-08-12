//
//  ARKNNViewController+TableView.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/7.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import AIDevLog

extension ARKNNViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "k", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row + 1)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        model = KNN(k: indexPath.row + 1, distanceMetric: Distance.euclideanDistance())
        tableView.isHidden = true
    }

}
