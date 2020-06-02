//
//  MovieDetailPresenter.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 31/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol MovieDetailViewProtocol: AnyObject {
    func updateMovieDetails(_ movie: MovieDetailViewModel, isFavorite: Bool)
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    private weak var view: MovieDetailViewProtocol?
    
    func setView(_ view: MovieDetailViewProtocol) {
        self.view = view
    }
    
    func presentMovieDetails(_ movie: MovieResponseModel, isFavorite: Bool) {
        
        let viewModel = MovieDetailViewModel(title: movie.title,
                                             posterPath: movie.posterPath,
                                             backdropPath: movie.backdropPath,
                                             isFavorite: movie.isFavorite ?? false,
                                             movieOverview: movie.overview,
                                             year: movie.getYearText())
        
        self.view?.updateMovieDetails(viewModel, isFavorite: isFavorite)
    }
}
