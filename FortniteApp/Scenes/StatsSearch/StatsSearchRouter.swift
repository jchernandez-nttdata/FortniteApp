//
//  StatsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

protocol StatsSearchRouterProtocol {
    
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
        
        return viewController
    }
    
}

extension StatsSearchRouter: StatsSearchRouterProtocol {
    
}
