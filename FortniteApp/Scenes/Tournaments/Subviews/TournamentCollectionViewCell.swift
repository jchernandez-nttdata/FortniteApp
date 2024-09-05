//
//  TournamentCollectionViewCell.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 4/09/24.
//

import UIKit

class TournamentCollectionViewCell: UICollectionViewCell {
    static let identifier = "TournamentCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .semibold)
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
        titleLabel.text = nil
        timeLabel.text = nil
        posterImageView.image = nil
    }
    
    private func setup() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor),
            
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setup(title: String, timeUntil: String?, posterUrl: String?) {
        titleLabel.text = title
        timeLabel.text = timeUntil
                
        // uses default image if posterURL is nil
        if let posterUrl {
            NetworkImageHelper.shared.getCacheImage(from: posterUrl) {[weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                case .failure(_):
                    // uses default image on failure
                    DispatchQueue.main.async {
                        self?.posterImageView.image = UIImage(resource: .defaultEvent)
                    }
                }
            }
        }
        
    }
    
}
