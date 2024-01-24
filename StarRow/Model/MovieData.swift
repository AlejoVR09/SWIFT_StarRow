//
//  MovieData.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import Foundation

import Foundation

// MARK: - Welcome
import Foundation

// MARK: - Welcome
struct MovieData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]?
        let id: Int?
        let originalLanguage: OriginalLanguage?
        let originalTitle, overview: String?
        let popularity: Double?
        let posterPath, releaseDate, title: String?
    
    enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
        }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ru = "ru"
}
