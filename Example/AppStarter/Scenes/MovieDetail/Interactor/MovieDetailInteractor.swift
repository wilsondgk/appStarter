//
//  MovieDetailInteractor.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 31/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    func presentMovieDetails(_ movie: MovieResponseModel, isFavorite: Bool)
}

protocol MovieDetailWorkerProtocol {
    func saveFavoriteMovie(_ movie: MovieResponseModel, sucessCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void)
    func unfavoriteMovie(_ movie: MovieResponseModel, sucessCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void)
}

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    private let presenter: MovieDetailPresenterProtocol
    private let worker: MovieDetailWorkerProtocol
    private let movieModel: MovieResponseModel
    private var isFavorite: Bool
    
    init(withPresenter presenter: MovieDetailPresenterProtocol,
         withWorker worker: MovieDetailWorkerProtocol,
         andMovie movie: MovieResponseModel,
         isFavorite: Bool) {
        self.presenter = presenter
        self.worker = worker
        self.movieModel = movie
        self.isFavorite = isFavorite
    }
    
    //MARK: MovieDetailInteractorProtocol
    func viewDidLoad() {
        presenter.presentMovieDetails(movieModel, isFavorite: isFavorite)
    }
    
    func favoriteButtonClicked() {
        if isFavorite {
            favoriteMovie()
            return
        }
        unFavoriteMovie()
    }
    
    private func favoriteMovie() {
        worker.unfavoriteMovie(movieModel, sucessCompletion: { [weak self] in
            if let strongSelf = self {
                strongSelf.presenter.presentMovieDetails(strongSelf.movieModel, isFavorite: !strongSelf.isFavorite)
            }
        }) { (error) in
            //todo show error
        }
    }
    
    private func unFavoriteMovie() {
        worker.saveFavoriteMovie(movieModel, sucessCompletion: { [weak self] in
            if let strongSelf = self {
                strongSelf.presenter.presentMovieDetails(strongSelf.movieModel, isFavorite: !strongSelf.isFavorite)
            }
        }) { (error) in
            //todo show error
        }
    }
}


