//
//  TournamentDetailViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import UIKit
import SkeletonView

protocol TournamentDetailView: AnyObject {
    func setupEventDetails()
    func reloadWindowData()
    func showLoading()
    func dismissLoading()
}

final class TournamentDetailViewController: UIViewController {
    var presenter: TournamentDetailPresenterProtocol!
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.configuration = .borderless()
        button.configuration?.imagePadding = 10
        return button
    }()
    
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
    
    private let imageSection: EventImageSectionView = {
        let view = EventImageSectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let windowsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WindowCollectionViewCell.self, forCellWithReuseIdentifier: WindowCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let scoringTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scoring"
        return label
    }()
    
    private let scoringCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isSkeletonable = true
        
        collectionView.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: ScoreCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let eliminationsLabel: TitleValueLabel = {
        let label = TitleValueLabel()
        label.isTitleBold = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultsTableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.isSkeletonable = true
        return tableView
    }()
    
    override func viewDidLoad() {
        setup()
        presenter.handleViewDidLoad()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .never
        title = presenter.event.title
        
        // back button config
        backButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageSection)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(windowsCollectionView)
        contentView.addSubview(scoringTitleLabel)
        contentView.addSubview(scoringCollectionView)
        contentView.addSubview(eliminationsLabel)
        contentView.addSubview(resultsTableView)
        
        windowsCollectionView.delegate = self
        windowsCollectionView.dataSource = self
        scoringCollectionView.delegate = self
        scoringCollectionView.dataSource = self
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        
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
            
            imageSection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageSection.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            windowsCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            windowsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            windowsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            windowsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            scoringTitleLabel.topAnchor.constraint(equalTo: windowsCollectionView.bottomAnchor, constant: 30),
            scoringTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoringTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            scoringCollectionView.topAnchor.constraint(equalTo: scoringTitleLabel.bottomAnchor, constant: 10),
            scoringCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoringCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            scoringCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            eliminationsLabel.topAnchor.constraint(equalTo: scoringCollectionView.bottomAnchor, constant: 15),
            eliminationsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eliminationsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            resultsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultsTableView.topAnchor.constraint(equalTo: eliminationsLabel.bottomAnchor, constant: 20),
            resultsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func popView() {
        presenter.handleBackButtonTap()
    }
}

extension TournamentDetailViewController: TournamentDetailView {
    func setupEventDetails() {
        DispatchQueue.main.async {
            self.imageSection.setup(imageUrl: self.presenter.event.loadingScreen)
            self.descriptionLabel.text = self.presenter.event.shortDescription
        }
    }
    
    func reloadWindowData() {
        DispatchQueue.main.async {
            self.windowsCollectionView.reloadData()
            self.scoringCollectionView.reloadData()
            self.resultsTableView.reloadData()
            
            let eachElimination = "+\(self.presenter.windowEliminationValue ?? 0) points"
            self.eliminationsLabel.setup(title: "Each elimination", value: String(eachElimination))
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.scoringCollectionView.showAnimatedSkeleton(usingColor: .lightGray)
            self.resultsTableView.showAnimatedSkeleton(usingColor: .lightGray)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.scoringCollectionView.hideSkeleton()
            self.resultsTableView.hideSkeleton()
        }
    }
}

// MARK: - Window and Scoring collection view config
extension TournamentDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case windowsCollectionView:
            presenter.event.sortedWindows.count
        case scoringCollectionView:
            presenter.windowScoring?.rewardTiers.count ?? 0
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case windowsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindowCollectionViewCell.identifier, for: indexPath) as? WindowCollectionViewCell
            let window = presenter.event.sortedWindows[indexPath.row]
            cell?.setup(isActive: window.windowId == presenter.selectedWindow!.windowId, session: indexPath.row + 1, startDate: window.beginTime, endDate: window.endTime)
            return cell ?? UICollectionViewCell()
        case scoringCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreCollectionViewCell.identifier, for: indexPath) as? ScoreCollectionViewCell
            guard let scores = presenter.windowScoring?.rewardTiers else {
                return UICollectionViewCell()
            }
            let score = scores[indexPath.row]
            cell?.setup(value: score.keyValue, points: score.pointsEarned)
            return cell ?? UICollectionViewCell()
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case windowsCollectionView:
            CGSize(width: 150, height: 80)
        case scoringCollectionView:
            CGSize(width: 130, height: 70)
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case windowsCollectionView:
            presenter.handleWindowSelect(at: indexPath.row)
        default:
            break
        }
    }
}

// MARK: - Results table view config
extension TournamentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.windowResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell
        let resultItem = presenter.windowResults[indexPath.row]
        cell?.setup(position: resultItem.rank, playerName: resultItem.teamNamesString, points: resultItem.pointsEarned)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.windowResults.isEmpty ? nil : "Results"
    }
}

// MARK: - Skeleton view configuration
extension TournamentDetailViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate,  SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    
    // Results table view sekeleton configuration
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        ResultTableViewCell.identifier
    }
    
    // Window and score collection view sekeleton configuration
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case scoringCollectionView:
            ScoreCollectionViewCell.identifier
        default:
            fatalError()
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}
