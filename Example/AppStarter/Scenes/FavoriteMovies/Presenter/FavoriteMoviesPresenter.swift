//
//  FavoriteMoviesPresenter.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 29/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol FavoriteMoviesViewProtocol: class {
    func updateFavoriteMovies(withViewModels viewModels: [FavoriteMovieViewModel])
}

class FavoriteMoviesPresenter: FavoriteMoviesPresenterProtocol {
    
    private weak var view: FavoriteMoviesViewProtocol?
    
    func setView(_ view: FavoriteMoviesViewProtocol) {
        self.view = view
    }
    
    func presentFavoriteMovies(_ movies: [MovieResponseModel]) {
        let movieViewModels = movies.map { (model) -> FavoriteMovieViewModel in
            return FavoriteMovieViewModel(title: model.title)
        }
        view?.updateFavoriteMovies(withViewModels: movieViewModels)
    }
}
