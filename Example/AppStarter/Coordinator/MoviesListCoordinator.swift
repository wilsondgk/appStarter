//
//  MovieListCoordinator.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 20/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AppStarter

final class MoviesListCoordinator: Coordinator, MoviesListNavigationProtocol {
    
    private let navigationController: UINavigationController
    let context: NSManagedObjectContext
    
    init(withNavigationController navigationController: UINavigationController, andViewContext context: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.context = context
    }
    
    func start() {
        let presenter = MoviesListPresenter()
        let worker = MoviesListWorker(withExternalProvider: MoyaApiProvider(),
                                      andLocalProvider: CoreDataProvider(withContext: context))
        let interactor = MoviesListInteractor(withCoordinator: self,
                                              withPresenter: presenter,
                                              andWorker: worker)
        let movieListVC = MoviesListViewController(withInteractor: interactor)
        presenter.setView(movieListVC)
        movieListVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_list_icon") , tag: 0)
        navigationController.setViewControllers([movieListVC], animated: true)
    }
    
    //MARK: MoviesListNavigationProtocol
    func showMovieDetailVC(fromMovie movie: MovieResponseModel, isFavorite: Bool) {
        let presenter = MovieDetailPresenter()
        let worker = MovieDetailWorker(withProvider: CoreDataProvider(withContext: context))
        let interactor = MovieDetailInteractor(withPresenter: presenter,
                                               withWorker: worker,
                                               andMovie: movie,
                                               isFavorite: isFavorite)
        let movieDetailVC = MovieDetailViewController(withInteractor: interactor)
        presenter.setView(movieDetailVC)
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
