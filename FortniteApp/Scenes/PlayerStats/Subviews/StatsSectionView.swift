//
//  StatsSectionView.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import UIKit

class StatsSectionView: UIView {
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let kdStatCard: StatCard = {
        let card = StatCard()
        return card
    }()
    
    private let victoriesStatCard: StatCard = {
        let card = StatCard()
        return card
    }()
    
    private let matchesStatCard: StatCard = {
        let card = StatCard()
        return card
    }()
    
    private let hoursStatCard: StatCard = {
        let card = StatCard()
        return card
    }()
    
    private let firstRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    private let secondRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        addSubview(sectionTitleLabel)
        addSubview(mainStackView)
        
        firstRowStackView.addArrangedSubview(kdStatCard)
        firstRowStackView.addArrangedSubview(victoriesStatCard)
        secondRowStackView.addArrangedSubview(matchesStatCard)
        secondRowStackView.addArrangedSubview(hoursStatCard)
        
        mainStackView.addArrangedSubview(firstRowStackView)
        mainStackView.addArrangedSubview(secondRowStackView)
        
        NSLayoutConstraint.activate([
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 15),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func setupSkeleton() {
        kdStatCard.isSkeletonable = true
        victoriesStatCard.isSkeletonable = true
        matchesStatCard.isSkeletonable = true
        hoursStatCard.isSkeletonable = true
    }
    
    func setup(sectionTitle: String, stats: ModeStats) {
        sectionTitleLabel.text = sectionTitle
        kdStatCard.setup(iconResource: .shotIcon, value: String(stats.kd), title: "Kill / deaths")
        victoriesStatCard.setup(iconResource: .victoryIcon, value: String(stats.placetop1), title: "Victory royales")
        matchesStatCard.setup(iconResource: .pickaxeIcon, value: String(stats.matchesplayed), title: "Matches played")
        hoursStatCard.setup(iconResource: .controllerIcon, value: String(stats.hoursPlayed), title: "Hours played")
    }
        
    func showLoading() {
        kdStatCard.showAnimatedSkeleton(usingColor: .lightGray)
        victoriesStatCard.showAnimatedSkeleton(usingColor: .lightGray)
        matchesStatCard.showAnimatedSkeleton(usingColor: .lightGray)
        hoursStatCard.showAnimatedSkeleton(usingColor: .lightGray)
    }
    
    func hideLoading() {
        kdStatCard.hideSkeleton()
        victoriesStatCard.hideSkeleton()
        matchesStatCard.hideSkeleton()
        hoursStatCard.hideSkeleton()
    }
}
