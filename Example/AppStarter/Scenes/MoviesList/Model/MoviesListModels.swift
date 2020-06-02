//
//  MoviesListModels.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 22/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

struct GeneralMovieResponseModel: Codable {
    
    var totalPages: Int
    var totalResults: Int
    var currentPage: Int
    var results: [MovieResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case currentPage = "page"
        case results = "results"
    }
}

struct MovieResponseModel: Codable {
    var id: Int64
    var title: String
    var isFavorite: Bool? = false
    var averageRating: Double
    var releaseDate: String
    var overview: String
    var posterPath: String
    var backdropPath: String?
    
    func getYearText() -> String {
        let date = Date.dateFrom(string: releaseDate, withFormat: "yyyy-MM-dd")
        let year = date == nil ? "N/A" : String(date!.getYearValue())
        return year
    }
//    var averageRating: Double
//    var genresIds: [Int]
//    var originalTitle: String
//    var isAdult: Bool
//    var popularity: Double
//    var originalLanguage: String
//    var voteCount: Int64
//    var isVideo: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case averageRating = "vote_average"
        case releaseDate = "release_date"
        case overview = "overview"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
//        case genresIds = "genre_ids"
//        case originalTitle = "original_title"
//        case isAdult = "adult"
//        case popularity = "popularity"
//        case originalLanguage = "original_language"
//        case voteCount = "vote_count"
//        case isVideo = "video"
    }
}
