//
//  MoviesListInteractor.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

protocol MoviesListPresenterProtocol {
    func presentLoadingState()
    func presentError(_ error: Error?)
    func presentMovies(_ movies: [MovieResponseModel], withFavoriteMovies favoriteMovies: [Int64: Bool?])
}

protocol MoviesListWorkerProtocol {
    func getFavoriteMoviesList(successCompletion: @escaping (_ movies: [MovieResponseModel]) -> Void, failCompletion: @escaping (_ error: Error) -> Void)
    func getMoviesList(fromPage page: Int, successCompletion: @escaping (_ movies: GeneralMovieResponseModel) -> Void, failCompletion: @escaping (_ error: Error) -> Void)
}

protocol MoviesListNavigationProtocol: class {
    func showMovieDetailVC(fromMovie movie: MovieResponseModel, isFavorite: Bool)
}

final class MoviesListInteractor: MoviesListInteractorProtocol {
    
    private let coordinator: MoviesListNavigationProtocol
    private let presenter: MoviesListPresenterProtocol
    private let worker: MoviesListWorkerProtocol
    private var movieModelList: [MovieResponseModel] = []
    private var favoriteMoviesDict: [Int64: Bool?] = [:]
    private var isLoadingMovies: Bool = false
    private var didReachLastPage: Bool = false
    private var currentPage: Int = 1
    
    init(withCoordinator coordinator: MoviesListNavigationProtocol,
         withPresenter presenter: MoviesListPresenterProtocol,
         andWorker worker: MoviesListWorkerProtocol) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
    }
    
    //MARK: MoviesListInteractorProtocol
    func viewDidLoad() {
        presenter.presentLoadingState()
        self.worker.getFavoriteMoviesList(successCompletion: { [weak self] (movies) in
            movies.forEach { (movie) in
                self?.favoriteMoviesDict[movie.id] = true
            }
            self?.getMovieList()
        }) { [weak self] (error) in
            self?.presenter.presentError(error)
        }
    }
    
    func reloadFavoriteMovies() {
        presenter.presentLoadingState()
        clearFavoriteMoviesDict()
        worker.getFavoriteMoviesList(successCompletion: { [weak self] (movies) in
            guard let strongSelf = self else {
                return
            }
            movies.forEach { (movie) in
                strongSelf.favoriteMoviesDict[movie.id] = true
            }
            strongSelf.presenter.presentMovies(strongSelf.movieModelList, withFavoriteMovies: strongSelf.favoriteMoviesDict)
        }) { [weak self] (error) in
            self?.presenter.presentError(error)
            return
        }
    }
    
    private func clearFavoriteMoviesDict() {
        favoriteMoviesDict = [:]
    }
    
    func retrybuttonClicked() {
        viewDidLoad()
    }
    
    func getMovieList() {
        if isLoadingMovies || didReachLastPage { return }
        isLoadingMovies = true
        worker.getMoviesList(fromPage: currentPage, successCompletion: { [weak self] result in
            guard let strongSelf = self else {
                self?.presenter.presentError(nil)
                return
            }
            strongSelf.movieModelList += result.results
            strongSelf.presenter.presentMovies(strongSelf.movieModelList, withFavoriteMovies: strongSelf.favoriteMoviesDict)
            strongSelf.didReachLastPage = result.currentPage == result.totalPages
            strongSelf.currentPage += 1
            strongSelf.isLoadingMovies = false
        }) { [weak self] (error) in
            self?.presenter.presentError(error)
            self?.isLoadingMovies = false
        }
    }
    
    func didClickInMovie(atIndex indexPath: IndexPath) {
        if movieModelList.indices.contains(indexPath.row) {
            let movie = movieModelList[indexPath.row]
            let isFavorite = favoriteMoviesDict[movie.id] == nil ? false : true
            coordinator.showMovieDetailVC(fromMovie: movie, isFavorite: isFavorite)
        }
    }
}
