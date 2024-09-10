//
//  TitleL.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

final class TitleValueLabel: UIView {
    var isTitleBold: Bool = true
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(label)
        label.pinToSuperview()
    }
    
    func setup(title: String, value: String) {
        let attributedString = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: isTitleBold ? .bold : .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        let regularString = NSAttributedString(string: " \(value)", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: isTitleBold ? .regular : .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        attributedString.append(regularString)
        
        label.attributedText = attributedString
    }
}
