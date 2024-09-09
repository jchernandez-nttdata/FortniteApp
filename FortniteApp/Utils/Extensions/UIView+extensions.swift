//
//  UIView+extensions.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

extension UIView {
    /// Pins this view to it's superview.
    func pinToSuperview() {
        guard let superview = superview else { fatalError("UIView+pinToSuperview: \(description) has no superview.") }
        pin(to: superview)
    }
    
    /// Pins this view to another view.
    func pin(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
