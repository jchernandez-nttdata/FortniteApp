//
//  TournamentsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/24.
//

import UIKit
import SkeletonView

protocol TournamentsView: AnyObject {
    func reloadCollectionView()
    func showLoading()
    func dismissLoading()
}

final class TournamentsViewController: UIViewController {
    
    var presenter: TournamentsPresenterProtocol!
    
    // MARK: UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(TournamentCollectionViewCell.self, forCellWithReuseIdentifier: TournamentCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current season: Chapter 5 Season 4"
        label.textColor = .black
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Region:"
        label.textColor = .black
        return label
    }()
    
    private let regionPicker: RegionPicker = {
        let picker = RegionPicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let regionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let spacer: UIView = {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return spacer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSkeleton()
        presenter.handleViewDidLoad()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = "Tournaments"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(regionStackView)
        view.addSubview(seasonLabel)
        
        regionStackView.addArrangedSubview(regionLabel)
        regionStackView.addArrangedSubview(regionPicker)
        regionStackView.addArrangedSubview(spacer)
        
        regionPicker.onRegionSelected = onRegionSelected(region:)
        
        NSLayoutConstraint.activate([
            seasonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            seasonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            seasonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            regionPicker.widthAnchor.constraint(equalToConstant: 70),
            
            regionStackView.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            regionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            regionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: regionStackView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupSkeleton() {
        collectionView.isSkeletonable = true
    }
    
    private func onRegionSelected(region : Region) {
        presenter.handleRegionChanged(region: region)
    }
    
}

extension TournamentsViewController: TournamentsView {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.collectionView.showAnimatedSkeleton(usingColor: .lightGray)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.collectionView.hideSkeleton()
        }
    }
    
}

extension TournamentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.tournamentSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = presenter.tournamentSections[section]
        switch section {
        case .upcomingEvents:
            return presenter.eventsCount.upcoming
        case .endedEvents:
            return presenter.eventsCount.ended
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = presenter.tournamentSections[indexPath.section]
        presenter.handleDidSelectEvent(at: indexPath.row, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // All sections uses the same cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TournamentCollectionViewCell.identifier, for: indexPath) as? TournamentCollectionViewCell
        
        let section = presenter.tournamentSections[indexPath.section]
        switch section {
        case .upcomingEvents:
            let event = presenter.getEvent(at: indexPath.row, section: .upcomingEvents)
            cell?.setup(title: event.title, timeUntil: event.formattedTimeUntil, posterUrl: event.poster)
            return cell ?? UICollectionViewCell()
        case .endedEvents:
            let event = presenter.getEvent(at: indexPath.row, section: .endedEvents)
            cell?.setup(title: event.title, timeUntil: event.formattedTimeUntil, posterUrl: event.poster)
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    // Sets the tournament event cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.4)
    }
    
    
    // Configure section header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier, for: indexPath) as? SectionHeaderCollectionReusableView
            
            let section = presenter.tournamentSections[indexPath.section]
            sectionHeader?.setup(title: section.rawValue)
            return sectionHeader ?? UICollectionViewCell()
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    // Section header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
}

extension TournamentsViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        TournamentCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        SectionHeaderCollectionReusableView.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        2
    }
    
}
