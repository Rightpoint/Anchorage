//
//  EdgeContainedLabelCell
//  AnchorageDemo
//
//  Created by Connor Neville on 9/21/16.
//  Copyright © 2016 Connor Neville. All rights reserved.
//

import UIKit

class EdgeContainedLabelCell: BaseCell {
    override class func reuseId() -> String {
        return "EdgeContainedCell"
    }

    let bodyLabel: UILabel = {
        let l = UILabel()
        l.text = "The edges of this UILabel are constrained to the edges of this cell's contentView, with 40pt padding on all sides. Tap to adjust the font size, and see the contentView adjust to meet the constraints."
        l.font = UIFont.systemFont(ofSize: 12.0)
        l.numberOfLines = 0
        return l
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
    }

    override func update(forDataSource dataSource: RootViewDataSource) {
        // UILabel has an intrinsic content size based on its font size, so all we need to do
        // is change the font size, and auto layout handles its width/height.
        bodyLabel.font = UIFont.systemFont(ofSize: dataSource.edgeContainedLabelCellFontSize)
    }
}

private extension EdgeContainedLabelCell {
    func configureView() {
        contentView.addSubview(bodyLabel)
    }

    func configureLayout() {
        bodyLabel.edgeAnchors == contentView.edgeAnchors + 40
    }
}
