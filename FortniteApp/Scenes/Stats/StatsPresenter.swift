//
//  StatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsPresenterProtocol {
    
}

final class StatsPresenter {
    
    unowned var view: StatsView!
    var interactor: StatsInteractorProtocol!
    var router: StatsRouterProtocol!
    
}

extension StatsPresenter: StatsPresenterProtocol {
    
}
