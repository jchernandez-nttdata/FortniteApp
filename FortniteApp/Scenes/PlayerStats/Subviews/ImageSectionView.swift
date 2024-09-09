//
//  ImageSectionView.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

class ImageSectionView: UIView {
    
    private let profileImages: [UIImage] = [.profileImage1, .profileImage2, .profileImage3, .profileImage4, .profileImage5]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .tertiaryLabel
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.image = profileImages[Int.random(in: 0..<profileImages.count)]
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
        
    }
    
}
