//
//  RootViewController.swift
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UITableViewController {
    let cellTypes: [BaseCell.Type] = [
        EdgeContainedLabelCell.self,
        MinimumWidthViewCell.self,
        ToggleActiveHeightCell.self,
        EqualSpaceViewCell.self,
        AnimatableConstraintCell.self
    ]
    let dataSource = RootViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        for cellType in cellTypes {
            tableView.register(cellType, forCellReuseIdentifier: cellType.reuseId())
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypes[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseId()) as? BaseCell else {
            preconditionFailure("Cell missing for reuse ID \(cellType.reuseId())")
        }
        cell.update(forDataSource: dataSource)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellTypes[indexPath.row] {
        case is EdgeContainedLabelCell.Type:
            dataSource.edgeContainedLabelCellFontSize += 4.0
            if dataSource.edgeContainedLabelCellFontSize >= 24.0 {
                dataSource.edgeContainedLabelCellFontSize = 12.0
            }
        case is MinimumWidthViewCell.Type:
            dataSource.minimumWidthConstraintConstant += 40
        case is ToggleActiveHeightCell.Type:
            dataSource.toggleHeightConstraintIsActive = !dataSource.toggleHeightConstraintIsActive
        case is EqualSpaceViewCell.Type:
            dataSource.equalSpacingConstraintConstant = (dataSource.equalSpacingConstraintConstant == 0) ?
                10.0 : 0.0
        case is AnimatableConstraintCell.Type:
            dataSource.animatableConstraintConstant = 200.0
        default:
            break
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

class RootViewDataSource {
    var edgeContainedLabelCellFontSize: CGFloat = 12.0
    var minimumWidthConstraintConstant: CGFloat =  100.0
    var toggleHeightConstraintIsActive: Bool = true
    var equalSpacingConstraintConstant: CGFloat = 0.0
    var animatableConstraintConstant: CGFloat = 0.0
}
