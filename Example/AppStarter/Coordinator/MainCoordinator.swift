//
//  MainCoordinator.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 20/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AppStarter

final class MainCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let context: NSManagedObjectContext
    private var childCoordinators: [Coordinator] = []
    
    init(withNavigationController navigationController: UINavigationController, andViewContext context: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.context = context
    }
    
    func start() {
        let tabBarVC = BaseTabBarViewController(withViewControllers: [createMovieListViewController(), createFavoriteMoviesViewController()])
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabBarVC, animated: false)
    }
    
    private func createMovieListViewController() -> UINavigationController {
        let navVC = BaseNavigationController()
        navVC.setColorProvider(Colors())
        let moviesListCoordinator = MoviesListCoordinator(withNavigationController: navVC, andViewContext: context)
        childCoordinators.append(moviesListCoordinator)
        moviesListCoordinator.start()
        
        return navVC
    }
    
    private func createFavoriteMoviesViewController() -> UINavigationController {
        let navVC = BaseNavigationController()
        navVC.setColorProvider(Colors())
        let favoriteCoordinator = FavoriteMoviesCoordinator(withNavigationController: navVC, andViewContext: context)
        childCoordinators.append(favoriteCoordinator)
        favoriteCoordinator.start()
        
        return navVC
    }
}
