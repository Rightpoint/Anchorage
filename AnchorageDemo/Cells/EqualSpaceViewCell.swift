//
//  EqualSpaceViewCell.swift
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import UIKit

class EqualSpaceViewCell: BaseCell {
    override class func reuseId() -> String {
        return "EqualSpaceViewCell"
    }

    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "These views take up the width of the cell by pinning to its leading, trailing, and having a constant space in between. Tap to adjust the space in between."
        l.font = UIFont.systemFont(ofSize: 12.0)
        l.numberOfLines = 0
        return l
    }()

    let views: [UIView] = {
        var views: [UIView] = []
        for i in 0...5 {
            let view = UIView()
            view.backgroundColor = (i % 2 == 0) ? UIColor.green : UIColor.cyan
            views.append(view)
        }
        return views
    }()
    // Here we have an array of constraints that we'll alter later.
    var spacingConstraints: [NSLayoutConstraint] = []

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }

    override func update(forDataSource dataSource: RootViewDataSource) {
        for constraint in spacingConstraints {
            constraint.constant = dataSource.equalSpacingConstraintConstant
        }
        layoutIfNeeded()
    }
}

private extension EqualSpaceViewCell {
    func configureView() {
        contentView.addSubview(bodyLabel)
        for view in views {
            contentView.addSubview(view)
        }
    }

    func configureLayout() {
        bodyLabel.topAnchor == contentView.topAnchor
        bodyLabel.horizontalAnchors == contentView.horizontalAnchors + 10

        guard let first = views.first, let last = views.last else {
            preconditionFailure("Empty views array in EqualSpaceViewCell")
        }

        first.leadingAnchor == contentView.leadingAnchor
        first.topAnchor == bodyLabel.bottomAnchor + 5
        first.heightAnchor == 30
        first.bottomAnchor == contentView.bottomAnchor

        for i in 1..<views.count {
            views[i].widthAnchor == first.widthAnchor
            views[i].topAnchor == first.topAnchor
            views[i].bottomAnchor == first.bottomAnchor
            // Each view's leading anchor is at the previous view's trailing anchor.
            // As long as you're targeting iOS 9+, situations like this can often be handled with UIStackView.
            spacingConstraints.append(views[i].leadingAnchor == views[i - 1].trailingAnchor)
        }

        last.trailingAnchor == contentView.trailingAnchor
    }
}
