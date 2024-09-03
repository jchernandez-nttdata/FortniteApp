//
//  StatsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/24.
//

import UIKit

protocol StatsView: AnyObject {
    
}

final class StatsViewController: UIViewController {
    
    var presenter: StatsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Stats"
    }

}

extension StatsViewController: StatsView {
    
}
