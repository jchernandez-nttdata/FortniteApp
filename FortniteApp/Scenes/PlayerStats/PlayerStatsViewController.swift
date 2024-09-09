//
//  PlayerStatsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

protocol PlayerStatsView: AnyObject {
    func setupStats(stats: PlayerStats)
    func showLoading()
    func dismissLoading()
}

final class PlayerStatsViewController: UIViewController {
    
    var presenter: PlayerStatsPresenterProtocol!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.configuration = .borderless()
        button.configuration?.imagePadding = 10
        return button
    }()
    
    private let imageSectionView: ImageSectionView = {
        let imageSection = ImageSectionView()
        imageSection.translatesAutoresizingMaskIntoConstraints = false
        return imageSection
    }()
    
    private let levelLabel: TitleValueLabel = {
        let label = TitleValueLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let soloStats: StatsSectionView = {
        let section = StatsSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private let duoStats: StatsSectionView = {
        let section = StatsSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private let squadStats: StatsSectionView = {
        let section = StatsSectionView()
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSkeleton()
        presenter.handleViewDidLoad()

    }
    
    private func setup() {
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        let titleAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = titleAttribute
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // back button config
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageSectionView)
        contentView.addSubview(levelLabel)
        contentView.addSubview(soloStats)
        contentView.addSubview(duoStats)
        contentView.addSubview(squadStats)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            imageSectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            levelLabel.topAnchor.constraint(equalTo: imageSectionView.bottomAnchor, constant: 20),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            soloStats.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 20),
            soloStats.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            soloStats.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            duoStats.topAnchor.constraint(equalTo: soloStats.bottomAnchor, constant: 30),
            duoStats.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            duoStats.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            squadStats.topAnchor.constraint(equalTo: duoStats.bottomAnchor, constant: 30),
            squadStats.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            squadStats.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            squadStats.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    private func setupSkeleton() {
        imageSectionView.isSkeletonable = true
        levelLabel.isSkeletonable = true
    }
    
    @objc private func popView() {
        //TODO: Handle in router
        navigationController?.popViewController(animated: true)
    }
}


extension PlayerStatsViewController: PlayerStatsView {
    func setupStats(stats: PlayerStats) {
        DispatchQueue.main.async {
            // title setup
            self.title = stats.name
            
            // level setup
            self.levelLabel.setup(title: "Account level: ", value: String(stats.account.level))
            
            // stats setup
            self.soloStats.setup(sectionTitle: "Solo", stats: stats.global_stats.solo)
            self.duoStats.setup(sectionTitle: "Duo", stats: stats.global_stats.duo)
            self.squadStats.setup(sectionTitle: "Squads", stats: stats.global_stats.squad)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.imageSectionView.showAnimatedSkeleton(usingColor: .lightGray)
            self.levelLabel.showAnimatedSkeleton(usingColor: .lightGray)
            self.soloStats.showLoading()
            self.duoStats.showLoading()
            self.squadStats.showLoading()
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.imageSectionView.hideSkeleton()
            self.levelLabel.hideSkeleton()
            self.soloStats.hideLoading()
            self.duoStats.hideLoading()
            self.squadStats.hideLoading()
        }
    }
}
