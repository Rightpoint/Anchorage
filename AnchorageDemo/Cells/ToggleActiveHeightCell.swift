//
//  ToggleActiveHeightCell.swift
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import UIKit

class ToggleActiveHeightCell: BaseCell {
    override class func reuseId() -> String {
        return "ToggleActiveHeightCell"
    }

    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "Each view below takes up 50% of the width of the cell. The left view has a constant height, and the right view, initially, has the same height. Tap to toggle the right view's height constraint's isActive property."
        l.font = UIFont.systemFont(ofSize: 12.0)
        l.numberOfLines = 0
        return l
    }()

    let leftView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.purple
        return v
    }()

    let rightView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.orange
        return v
    }()
    // If you want to change or replace a constraint later, it's a good idea to keep a reference to it.
    var rightHeightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }

    override func update(forDataSource dataSource: RootViewDataSource) {
        // You can disable a constraint by setting isActive = false. If you replace an active constraint
        // with an entirely new one, the old one will still be active, so do this first to avoid 
        // unintentional layout conflicts!
        rightHeightConstraint?.isActive = dataSource.toggleHeightConstraintIsActive
        layoutIfNeeded()
    }
}

private extension ToggleActiveHeightCell {
    func configureView() {
        contentView.addSubview(bodyLabel)
        contentView.addSubview(leftView)
        contentView.addSubview(rightView)
    }

    func configureLayout() {
        bodyLabel.topAnchor == contentView.topAnchor
        bodyLabel.horizontalAnchors == contentView.horizontalAnchors + 10

        leftView.leftAnchor == contentView.leftAnchor
        leftView.rightAnchor == contentView.centerXAnchor
        leftView.topAnchor == bodyLabel.bottomAnchor + 5
        leftView.heightAnchor == 30
        leftView.bottomAnchor == contentView.bottomAnchor

        rightView.leftAnchor == contentView.centerXAnchor
        rightView.rightAnchor == contentView.rightAnchor
        rightView.topAnchor == leftView.topAnchor
        // When we set this to inactive, there is no specification for this view's height, so it is zero.
        rightHeightConstraint = (rightView.heightAnchor == leftView.heightAnchor)
    }
}
