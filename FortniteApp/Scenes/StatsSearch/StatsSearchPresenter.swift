//
//  StatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsSearchPresenterProtocol {
    func handleSearchQueryChanged(query: String)
}

final class StatsSearchPresenter {
    
    unowned var view: StatsSearchView!
    var interactor: StatsSearchInteractorProtocol!
    var router: StatsSearchRouterProtocol!
    
}

extension StatsSearchPresenter: StatsSearchPresenterProtocol {
    func handleSearchQueryChanged(query: String) {
        print(query)
    }
    
    
}
