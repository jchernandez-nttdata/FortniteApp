//
//  ResultTableViewCell.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 10/09/24.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier: String = "ResultTableViewCell"
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let playerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "player"
        return label
    }()
    
    private let playerValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let pointsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "points"
        label.textAlignment = .right
        return label
    }()
    
    private let pointsValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private let playerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let pointsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        positionLabel.text = nil
        playerValueLabel.text = nil
        pointsValueLabel.text = nil
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        playerStackView.addArrangedSubview(playerTitleLabel)
        playerStackView.addArrangedSubview(playerValueLabel)
        pointsStackView.addArrangedSubview(pointsTitleLabel)
        pointsStackView.addArrangedSubview(pointsValueLabel)
        
        contentView.addSubview(positionLabel)
        contentView.addSubview(playerStackView)
        contentView.addSubview(pointsStackView)


        NSLayoutConstraint.activate([
            positionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            positionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            positionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            positionLabel.widthAnchor.constraint(equalToConstant: 40),
            
            pointsStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pointsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pointsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pointsStackView.widthAnchor.constraint(equalToConstant: 60),
            
            playerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            playerStackView.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: 5),
            playerStackView.trailingAnchor.constraint(equalTo: pointsStackView.leadingAnchor, constant: -5),
            
        ])
    }
    
    func setup(position: Int, playerName: String, points: Int) {
        positionLabel.text = String(position)
        playerValueLabel.text = playerName
        pointsValueLabel.text = String(points)
    }
}
