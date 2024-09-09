//
//  TournamentDetailViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import UIKit

protocol TournamentDetailView: AnyObject {
    
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
    }
    
    @objc private func popView() {
        //TODO: Handle in router
        navigationController?.popViewController(animated: true)
    }
}

extension TournamentDetailViewController: TournamentDetailView {
    
}
