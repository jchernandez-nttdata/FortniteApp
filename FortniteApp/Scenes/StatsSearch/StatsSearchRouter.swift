//
//  StatsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

protocol StatsSearchRouterProtocol {
    func routeToPlayerStatsScreen(accountId: String)
}

final class StatsSearchRouter {
    
    unowned var viewController: UIViewController!
    
    static func createModule() -> UIViewController {
        let viewController = StatsSearchViewController()
        let presenter = StatsSearchPresenter()
        let router = StatsSearchRouter()
        let interactor = StatsSearchInteractor()
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}

extension StatsSearchRouter: StatsSearchRouterProtocol {
    func routeToPlayerStatsScreen(accountId: String) {
        let playerStatsViewController = PlayerStatsRouter.createModule(accountId: accountId)
        viewController.navigationController?.pushViewController(playerStatsViewController, animated: true)
    }
    
    
}
