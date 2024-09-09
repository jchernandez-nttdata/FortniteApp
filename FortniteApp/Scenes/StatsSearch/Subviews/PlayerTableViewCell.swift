//
//  PlayerTableViewCell.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import UIKit

enum PlayerTableViewCellType {
    case search, history
}

class PlayerTableViewCell: UITableViewCell {
    
    static let identifier: String = "PlayerTableViewCell"
    
    private var actionHandler: (() -> ())?
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let playerPlatformLabel: UILabel = {
        let label = UILabel()
        label.text = "Platform: "
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let playerInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupSkeleton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        setupSkeleton()
    }
    
    override func prepareForReuse() {
        playerNameLabel.text = nil
        playerPlatformLabel.text = "Platform: "
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        playerInfoStack.addArrangedSubview(playerNameLabel)
        playerInfoStack.addArrangedSubview(playerPlatformLabel)
        
        contentView.addSubview(playerInfoStack)
        contentView.addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(onActionTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            actionButton.widthAnchor.constraint(equalToConstant: 44),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            playerInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            playerInfoStack.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            playerInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playerInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setupSkeleton() {
        isSkeletonable = true
        playerInfoStack.isSkeletonable = true
        playerNameLabel.isSkeletonable = true
        playerPlatformLabel.isSkeletonable = true
        actionButton.isSkeletonable = true
    }
    
    @objc private func onActionTapped() {
        actionHandler?()
    }
    
    func setup(
        playerName: String,
        playerPlatform: String,
        cellType: PlayerTableViewCellType,
        actionHandler: (() -> ())? = nil
    ) {
        playerNameLabel.text = playerName
        playerPlatformLabel.text! += playerPlatform
        if cellType == .history {
            actionButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
        self.actionHandler = actionHandler
    }

}
