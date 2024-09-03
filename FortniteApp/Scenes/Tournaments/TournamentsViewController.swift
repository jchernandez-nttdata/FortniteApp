//
//  TournamentsViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/24.
//

import UIKit

protocol TournamentsView: AnyObject {
    
}

final class TournamentsViewController: UIViewController {
    
    var presenter: TournamentsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Tournaments"
    }

}

extension TournamentsViewController: TournamentsView {
    
}
