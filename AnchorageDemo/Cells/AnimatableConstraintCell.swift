//
//  AnimatableConstraintCell.swift
//  Anchorage
//
//  Created by Connor Neville on 9/26/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import UIKit

class AnimatableConstraintCell: BaseCell {
    override class func reuseId() -> String {
        return "AnimatableConstraintCell"
    }

    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "Constraints generated with Anchorage, just like any other constraints, can be animated by adjusting them and calling layoutIfNeeded inside an animation block. Tap to animate the below view across the screen."
        l.font = UIFont.systemFont(ofSize: 12.0)
        l.numberOfLines = 0
        return l
    }()

    let animatableView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        return v
    }()
    var animatableConstraint: NSLayoutConstraint?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }

    override func update(forDataSource dataSource: RootViewDataSource) {
        let newConstant = dataSource.animatableConstraintConstant
        // Just because we don't want to animate anything the first
        // time the cell loads.
        guard newConstant != 0 else {
            return
        }
        layoutIfNeeded()
        animatableConstraint?.constant = newConstant
        UIView.animate(withDuration: 0.5, animations: {
            // Animate the view's position change
            self.layoutIfNeeded()
            }, completion: { _ in
                self.animatableConstraint?.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    // Animate the view going back to its original position
                    self.layoutIfNeeded()
                })
        })
    }
}

private extension AnimatableConstraintCell {
    func configureView() {
        contentView.addSubview(bodyLabel)
        contentView.addSubview(animatableView)
    }

    func configureLayout() {
        bodyLabel.topAnchor == contentView.topAnchor
        bodyLabel.horizontalAnchors == contentView.horizontalAnchors + 10

        animatableView.topAnchor == bodyLabel.bottomAnchor + 10
        animatableConstraint = animatableView.leadingAnchor == contentView.leadingAnchor
        animatableView.widthAnchor == 20.0
        animatableView.heightAnchor == 20.0
        animatableView.bottomAnchor == contentView.bottomAnchor
    }
}
