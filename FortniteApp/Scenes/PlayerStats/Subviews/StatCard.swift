//
//  StatCard.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import UIKit

class StatCard: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let statValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let statTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
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
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        addSubview(stackView)
        stackView.pinToSuperview(constant: 10)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(statValueLabel)
        stackView.addArrangedSubview(statTitleLabel)
    }
    
    func setup(iconResource: ImageResource, value: String, title: String) {
        iconImageView.image = UIImage(resource: iconResource)
        statValueLabel.text = value
        statTitleLabel.text = title
    }
}
