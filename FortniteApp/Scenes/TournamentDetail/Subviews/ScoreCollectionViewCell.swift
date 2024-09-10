//
//  ScoreCollectionViewCell.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 10/09/24.
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    static let identifier = "ScoreCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        pointsLabel.text = ""
    }
    
    private func setup() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        isSkeletonable = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            
            pointsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            pointsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            pointsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    func setup(value: Int, points: Int) {
        titleLabel.text = value == 1 ? "Victory" : "Top \(value)"
        pointsLabel.text = "+\(points) points"
    }
}
