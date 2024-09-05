//
//  StatsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

protocol StatsRouterProtocol {
    
}

final class StatsRouter {
    
    unowned var viewController: UIViewController!
    
    static func createModule() -> UIViewController {
        let viewController = StatsViewController()
        let presenter = StatsPresenter()
        let router = StatsRouter()
        let interactor = StatsInteractor()
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        viewController.presenter = presenter
        
        return viewController
    }
    
}

extension StatsRouter: StatsRouterProtocol {
    
}
