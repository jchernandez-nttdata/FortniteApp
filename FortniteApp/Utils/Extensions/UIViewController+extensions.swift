//
//  UIViewController+extensions.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import UIKit

extension UIViewController {
    
    /// Adds a gesture recognizer to the view that dismisses the keyboard when the user taps anywhere outside of the keyboard.
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
