//
//  MovieDetailWorker.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 31/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import AppStarter

final class MovieDetailWorker: MovieDetailWorkerProtocol {
    
    private let provider: LocalApiProtocol
    
    init(withProvider provider: LocalApiProtocol) {
        self.provider = provider
    }
    
    func saveFavoriteMovie(_ movie: MovieResponseModel, sucessCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void) {
        let savingMovie = provider.bindMovie(toMovieData: movie)
        provider.saveObject(savingMovie, successCompletion: {
            sucessCompletion()
        }) { (error) in
            failCompletion(error)
        }
    }
    
    func unfavoriteMovie(_ movie: MovieResponseModel, sucessCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void) {
        let predicate = NSPredicate(format: "id = %@", argumentArray: [movie.id])
        provider.delete(MovieData.self, predicate: predicate, successCompletion: {
            sucessCompletion()
        }) { (error) in
            failCompletion(error)
        }
    }
}
