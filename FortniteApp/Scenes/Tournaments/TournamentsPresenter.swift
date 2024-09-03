//
//  TournamentsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol TournamentsPresenterProtocol {
    
}

final class TournamentsPresenter {
    
    weak var view: TournamentsView!
    var interactor: TournamentsInteractorProtocol!
    var router: TournamentsRouterProtocol!
    
}

extension TournamentsPresenter: TournamentsPresenterProtocol {
    
}
