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
        
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().barTintColor = .white
        
        let tournamentsVC = TournamentsRouter.createModule()
        let statsVC = StatsSearchRouter.createModule()
        
        tournamentsVC.navigationItem.largeTitleDisplayMode = .automatic
        statsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
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
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        
        let titleAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.titleTextAttributes = titleAttribute
        
        tournamentsNav.navigationBar.prefersLargeTitles = true
        tournamentsNav.navigationBar.standardAppearance = navBarAppearance
        statsNav.navigationBar.prefersLargeTitles = true
        statsNav.navigationBar.standardAppearance = navBarAppearance
        
        setViewControllers(
            [tournamentsNav,statsNav],
            animated: true
        )
    }
    
    
}

