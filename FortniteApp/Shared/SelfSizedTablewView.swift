//
//  SelfSizedTablewView.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 10/09/24.
//

import UIKit

class SelfSizingTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
