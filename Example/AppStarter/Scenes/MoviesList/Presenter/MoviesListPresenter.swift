//
//  MoviesListPresenter.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol MoviesListViewProtocol: class {
    func showLoading(withMessage message:String)
    func showError(_ error: Error?)
    func setNormalLayout()
    func updateMovies(withMoviesViewModel viewModels: [DefaultMovieViewModel])
}

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    private weak var view: MoviesListViewProtocol?
    
    func setView(_ view: MoviesListViewProtocol) {
        self.view = view
    }
    
    func presentLoadingState() {
        view?.showLoading(withMessage: "Carregando filmes...")
    }
    
    func presentMovies(_ movies: [MovieResponseModel], withFavoriteMovies favoriteMovies: [Int64 : Bool?]) {
        let viewModels = movies.map { (model) -> DefaultMovieViewModel in
            let isFavorite = favoriteMovies[model.id] == nil ? false : true
            let date = Date.dateFrom(string: model.releaseDate, withFormat: "yyyy-MM-dd")
            let year = date == nil ? "N/A" : String(date!.getYearValue())
            return DefaultMovieViewModel(name: model.title,
                                         ratingText: String(model.averageRating.getStringWithDecimal(1)),
                                         yearAndLengthText: "Lançamento \(year)",
                                         posterPath: model.posterPath,
                                         favoriteIconImage: isFavorite ? "favorite_movie_icon" : "not_favorite_movie_icon")
        }
        view?.setNormalLayout()
        view?.updateMovies(withMoviesViewModel: viewModels)
    }
    
    func presentError(_ error: Error?) {
        view?.showError(error)
    }
}
