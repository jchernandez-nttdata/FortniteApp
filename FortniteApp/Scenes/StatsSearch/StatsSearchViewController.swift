//
//  StatsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/24.
//

import UIKit
import SkeletonView

protocol StatsSearchView: AnyObject {
    func reloadSearchTableView()
    func reloadHistoryTableView()
    func showLoading()
    func dismissLoading()
    func setSearchTableViewVisibility(isHidden: Bool)
    func setHistoryTableViewVisibility(isHidden: Bool)
    func showError(title: String, description: String)
    func hideError()
}

final class StatsSearchViewController: UIViewController {
    
    var presenter: StatsSearchPresenterProtocol!
    private let searchDebouncer = DebouncerHelper(delay: 1)
    
    private let statsDecriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Start typing to search for player stats"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clearButton: UIButton = {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.tintColor = .black
        clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return clearButton
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        textField.keyboardType = .webSearch
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "e.g. Ninja", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        // left search icon with padding
        let searchImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        searchImageView.tintColor = .darkGray
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(searchImageView)
        searchImageView.center = leftView.center
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // TODO: use only one table view
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.identifier)
        tableView.register(PlayerTableHeaderView.self, forHeaderFooterViewReuseIdentifier: PlayerTableHeaderView.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.identifier)
        tableView.register(PlayerTableHeaderView.self, forHeaderFooterViewReuseIdentifier: PlayerTableHeaderView.identifier)
        return tableView
    }()
    
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupSkeleton()
        
        presenter.handleViewDidLoad()
    }
    
    private func setup() {
        view.backgroundColor = .white
        title = "Stats"
        
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(statsDecriptionLabel)
        view.addSubview(searchTextField)
        view.addSubview(searchTableView)
        view.addSubview(historyTableView)
        view.addSubview(errorView)
        
        // clear button init
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        rightView.addSubview(clearButton)
        searchTextField.rightView = rightView
        clearButton.center = rightView.center
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        searchTextField.addTarget(self, action: #selector(onSearchFieldChanged), for: .editingChanged)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            statsDecriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsDecriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statsDecriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.topAnchor.constraint(equalTo: statsDecriptionLabel.bottomAnchor, constant: 10),
            
            searchTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            searchTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            historyTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            historyTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            errorView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupSkeleton() {
        searchTableView.isSkeletonable = true
    }
    
    @objc private func clearTextField() {
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        presenter.handleSearchQueryChanged(query: "")
    }
    
    @objc private func onSearchFieldChanged(_ textField: UITextField) {
        searchDebouncer.run { [weak self] in
            self?.presenter.handleSearchQueryChanged(query: textField.text ?? "")
        }
    }

}

// MARK: - StatsSearchView
extension StatsSearchViewController: StatsSearchView {
    func reloadSearchTableView() {
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    func reloadHistoryTableView() {
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.searchTableView.showAnimatedSkeleton(usingColor: .lightGray)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.searchTableView.hideSkeleton()
        }
    }
    
    func setSearchTableViewVisibility(isHidden: Bool) {
        DispatchQueue.main.async {
            self.searchTableView.isHidden = isHidden
        }
    }
    
    func setHistoryTableViewVisibility(isHidden: Bool) {
        DispatchQueue.main.async {
            self.historyTableView.isHidden = isHidden
        }
    }
    
    func showError(title: String, description: String) {
        DispatchQueue.main.async {
            self.errorView.setup(title: title, description: description)
            self.errorView.isHidden = false
        }
    }
    
    func hideError() {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
        }
    }
}

// MARK: - Table view configuration
extension StatsSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case searchTableView:
            return presenter.playerMatches.count
        case historyTableView:
            return presenter.searchHistory.count
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell
        
        switch tableView {
        case searchTableView:
            let player = presenter.playerMatches[indexPath.row]
            cell?.setup(playerName: player.matches.first?.value ?? "", playerPlatform: player.matches.first?.platform ?? "", cellType: .search)
            return cell ?? UITableViewCell()
        case historyTableView:
            let player = presenter.searchHistory[indexPath.row]
            cell?.setup(
                playerName: player.name,
                playerPlatform: player.platform,
                cellType: .history,
                actionHandler: {
                    self.presenter.handleDeleteHistoryRecord(at: indexPath.row)
                }
            )
            return cell ?? UITableViewCell()
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlayerTableHeaderView.identifier) as? PlayerTableHeaderView
        switch tableView {
        case searchTableView:
            guard !presenter.playerMatches.isEmpty else {
                return nil
            }
            view?.setup(title: "Results")
            return view
        case historyTableView:
            guard !presenter.searchHistory.isEmpty else {
                return nil
            }
            view?.setup(title: "Recent searches")
            return view
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isHistory = switch tableView {
        case searchTableView:
            false
        case historyTableView:
            true
        default:
            fatalError()
        }
        presenter.handleDidSelectPlayer(at: indexPath.row, isHistory: isHistory)
    }

}

// MARK: - Skeleton configuration
extension StatsSearchViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        PlayerTableViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? PlayerTableViewCell else {
            return
        }
        cell.setup(playerName: " ", playerPlatform: " ", cellType: .search)
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        PlayerTableHeaderView.identifier
    }
    
}
