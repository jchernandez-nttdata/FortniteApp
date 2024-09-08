//
//  PlayerStatsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

protocol PlayerStatsView: AnyObject {
    
}

final class PlayerStatsViewController: UIViewController {
    
    var presenter: PlayerStatsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .asbestos
        presenter.handleViewDidLoad()
    }
}


extension PlayerStatsViewController: PlayerStatsView {
    
}
