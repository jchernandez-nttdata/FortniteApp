//
//  TournamentsRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import UIKit

protocol TournamentsRouterProtocol {
    
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
        
        return viewController
    }
    
}

extension TournamentsRouter: TournamentsRouterProtocol {
    
}
