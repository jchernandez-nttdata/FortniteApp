//
//  ViewController.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let tournamentsVC = TournamentsViewController()
        let statsVC = StatsRouter.createModule()
        
        tournamentsVC.navigationItem.largeTitleDisplayMode = .automatic
        statsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        tournamentsVC.navigationItem.standardAppearance = appearance
        statsVC.navigationItem.standardAppearance = appearance
        
        let tournamentsNav = UINavigationController(rootViewController: tournamentsVC)
        let statsNav = UINavigationController(rootViewController: statsVC)
        
        tournamentsNav.tabBarItem = UITabBarItem(
            title: "Tournaments",
            image: UIImage(systemName: "trophy.fill"),
            tag: 1
        )
        statsNav.tabBarItem = UITabBarItem(
            title: "Stats",
            image: UIImage(systemName: "chart.bar.fill"),
            tag: 2
        )
        
        tournamentsNav.navigationBar.prefersLargeTitles = true
        statsNav.navigationBar.prefersLargeTitles = true
        
        
        
        setViewControllers(
            [tournamentsNav,statsNav],
            animated: true
        )
    }
    
    
}

