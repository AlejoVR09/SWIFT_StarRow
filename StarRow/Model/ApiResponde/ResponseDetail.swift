//
//  ResponseDetail.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 7/02/24.
//

import Foundation

extension DetailsWS {
    struct Movie: Decodable {
        let adult: Bool?
            let backdropPath: String?
            let budget: Int?
            let genres: [Genre]?
            let homepage: String?
            let id: Int?
            let imdbID, originalLanguage, originalTitle, overview: String?
            let popularity: Double?
            let posterPath: String?
            let productionCompanies: [ProductionCompany]?
            let releaseDate: String?
            let revenue, runtime: Int?
            let status, tagline, title: String?
            let video: Bool?
            let voteAverage: Double?
            let voteCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case releaseDate = "release_date"
            case revenue, runtime
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}