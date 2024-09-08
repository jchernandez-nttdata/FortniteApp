//
//  PlayerStatsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import UIKit

protocol PlayerStatsRouterProtocol {
    
}

final class PlayerStatsRouter {
    unowned var viewController: PlayerStatsView!
    
    static func createModule(accountId: String) -> UIViewController {
        let viewController = PlayerStatsViewController()
        let presenter = PlayerStatsPresenter(accountId: accountId)
        let router = PlayerStatsRouter()
        let interactor = PlayerStatsInteractor()
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}


extension PlayerStatsRouter: PlayerStatsRouterProtocol {
    
}
