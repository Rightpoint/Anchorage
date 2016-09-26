//
//  BaseCell.swift
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    class func reuseId() -> String {
        return "BaseCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(forDataSource dataSource: RootViewDataSource) { }
}
