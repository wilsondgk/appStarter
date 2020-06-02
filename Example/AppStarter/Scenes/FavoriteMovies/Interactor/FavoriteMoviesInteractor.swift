//
//  FavoriteMoviesInteractor.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 29/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol FavoriteMoviesWorkerProtocol {
    func getFavoriteMovies(successCompletion: @escaping(_ movies: [MovieResponseModel]) -> Void, errorCompletion: @escaping(_ error: Error) -> Void)
}

protocol FavoriteMoviesPresenterProtocol {
    func presentFavoriteMovies(_ movies: [MovieResponseModel])
}

final class FavoriteMoviesInteractor: FavoriteMoviesInteractorProtocol {
     
    private let presenter: FavoriteMoviesPresenterProtocol
    private let worker: FavoriteMoviesWorkerProtocol
    
    init(withPresenter presenter: FavoriteMoviesPresenterProtocol,
         andWorker worker: FavoriteMoviesWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func viewDidLoad() {
        reloadFavoriteMovies()
    }
    
    func reloadFavoriteMovies() {
        worker.getFavoriteMovies(successCompletion: { [weak self](moviesList) in
            self?.presenter.presentFavoriteMovies(moviesList)
        }) { (errpr) in
            //TODO: add error
        }
    }
}
