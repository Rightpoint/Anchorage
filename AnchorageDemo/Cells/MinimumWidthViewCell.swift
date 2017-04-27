//
//  MinimumWidthViewCell.swift
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import UIKit

class MinimumWidthViewCell: BaseCell {
    override class func reuseId() -> String {
        return "MinimumWidthViewCell"
    }

    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "The red view will have 50% of the width of the blue view, but won't go above 100 pt, because the " +
        "constant requirement has a higher priority. Tap to expand the blue view."
        l.font = UIFont.systemFont(ofSize: 12.0)
        l.numberOfLines = 0
        return l
    }()

    let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.blue
        return v
    }()
    // If you want to change or replace a constraint later, it's a good idea to keep a reference to it.
    var blueWidthConstraint: NSLayoutConstraint?

    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.red
        return v
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }

    override func update(forDataSource dataSource: RootViewDataSource) {
        blueWidthConstraint?.constant = dataSource.minimumWidthConstraintConstant
        layoutIfNeeded()
    }
}

private extension MinimumWidthViewCell {
    func configureView() {
        contentView.addSubview(bodyLabel)
        contentView.addSubview(blueView)
        contentView.addSubview(redView)
    }

    func configureLayout() {
        bodyLabel.topAnchor == contentView.topAnchor + 10
        bodyLabel.horizontalAnchors == contentView.horizontalAnchors + 10

        blueWidthConstraint = (blueView.widthAnchor == 100)
        blueView.centerXAnchor == centerXAnchor
        blueView.topAnchor == bodyLabel.bottomAnchor + 5
        blueView.heightAnchor == 10

        // We have 2 constraints that dictate the height of the red view. Auto layout tries to 
        // satisfy both if possible, but if not, it'll satisfy the higher priority one.
        redView.widthAnchor == blueView.widthAnchor * 0.5 ~ .low + 1
        redView.widthAnchor <= 100 ~ .high

        redView.heightAnchor == 10
        redView.centerXAnchor == centerXAnchor
        redView.topAnchor == blueView.bottomAnchor + 5
        redView.bottomAnchor == contentView.bottomAnchor
    }
}
