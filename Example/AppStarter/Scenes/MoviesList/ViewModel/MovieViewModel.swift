//
//  MovieViewModel.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 27/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

struct DefaultMovieViewModel: Codable {
    let name: String
    let ratingText: String
    let yearAndLengthText: String
    let posterPath: String
    let favoriteIconImage: String
}
