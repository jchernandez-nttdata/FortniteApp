//
//  EventImageSectionView.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import UIKit

class EventImageSectionView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSkeleton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(imageView)
        imageView.pinToSuperview()
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupSkeleton() {
        isSkeletonable = true
        imageView.isSkeletonable = true
    }
    
    func setup(imageUrl: String?) {
        imageView.showAnimatedSkeleton(usingColor: .lightGray)
        if let imageUrl {
            NetworkImageHelper.shared.getCacheImage(from: imageUrl) {[weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.imageView.hideSkeleton()
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(resource: .defaultLoadingScreen)
                        self?.imageView.hideSkeleton()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.imageView.image = UIImage(resource: .defaultLoadingScreen)
                self.imageView.hideSkeleton()
            }
        }
    }
    
}
