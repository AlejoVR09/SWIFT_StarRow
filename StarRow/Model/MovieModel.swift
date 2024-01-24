//
//  MovieModel.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import Foundation

struct MovieModel {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
}
