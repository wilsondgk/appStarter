//
//  MoviesListWorker.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation
import AppStarter

final class MoviesListWorker: MoviesListWorkerProtocol {
    
    private let externalProvider: ApiProviderProtocol
    private let localProvider: LocalApiProtocol
    
    init(withExternalProvider externalProvider: ApiProviderProtocol, andLocalProvider localProvider: LocalApiProtocol) {
        self.externalProvider = externalProvider
        self.localProvider = localProvider
    }
    
    func getFavoriteMoviesList(successCompletion: @escaping (_ movies: [MovieResponseModel]) -> Void, failCompletion: @escaping (_ error: Error) -> Void) {
        localProvider.fetch(MovieData.self, predicate: nil, successCompletion: { (moviesData) in
            let movies = moviesData.compactMap { [weak self] (data) -> MovieResponseModel? in
                return self?.localProvider.bindMovieData(toMovieModel: data)
            }
            successCompletion(movies)
        }) { (error) in
            failCompletion(error)
        }
    }
    
    func getMoviesList(fromPage page: Int, successCompletion: @escaping (_ movies: GeneralMovieResponseModel) -> Void, failCompletion: @escaping (_ error: Error) -> Void) {
        let params = ["api_key" : "de94a58f8f1c55104fa3b01661f5c0d5",
                      "page" : String(page)]
        let request = RequestBuilder(withUrl: "https://api.themoviedb.org/3", andMethod: .get)
            .withPath("/movie/popular")
            .withQuery(params)
            .create()
        externalProvider.makeRequest(withRequestParams: request) { (response: (Response<GeneralMovieResponseModel, EmptyStruct>)) in
            switch response {
            case .success(let movies):
                successCompletion(movies)
                break
            case .failure(_, let error):
                failCompletion(error)
                break
            }
        }
    }
}
