//
//  TournamentsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

protocol TournamentsRouterProtocol {
    func routeToDetailScreen(event: Event)
}

final class TournamentsRouter {
    
    unowned var viewController: UIViewController!
    
    static func createModule() -> UIViewController {
        let viewController = TournamentsViewController()
        let presenter = TournamentsPresenter()
        let router = TournamentsRouter()
        let interactor = TournamentsInteractor()
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}

extension TournamentsRouter: TournamentsRouterProtocol {
    func routeToDetailScreen(event: Event) {
        let tournamentDetailViewController = TournamentDetailRouter.createModule(event: event)
        viewController.navigationController?.pushViewController(tournamentDetailViewController, animated: true)
    }
    
    
}
