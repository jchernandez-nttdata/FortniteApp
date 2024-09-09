//
//  UIView+extensions.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

extension UIView {
    /// Pins this view to it's superview.
    func pinToSuperview(constant: CGFloat = 0) {
        guard let superview = superview else { fatalError("UIView+pinToSuperview: \(description) has no superview.") }
        pin(to: superview, constant: constant)
    }
    
    /// Pins this view to another view.
    func pin(to view: UIView, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
    }
}
