//
//  TournamentDetailRouter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import UIKit

protocol TournamentDetailRouterProtocol {
    func routePop()
}

final class TournamentDetailRouter {
    unowned var viewController: UIViewController!
    
    static func createModule(event: Event) -> UIViewController {
        let presenter = TournamentDetailPresenter(event: event)
        let viewController = TournamentDetailViewController()
        let interactor = TournamentDetailInteractor()
        let router = TournamentDetailRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        router.viewController = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}

extension TournamentDetailRouter: TournamentDetailRouterProtocol {
    func routePop() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    
}
