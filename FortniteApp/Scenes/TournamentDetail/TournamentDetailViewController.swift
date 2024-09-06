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
    
    override func viewDidLoad() {
        title = presenter.event.title
    }
}

extension TournamentDetailViewController: TournamentDetailView {
    
}
