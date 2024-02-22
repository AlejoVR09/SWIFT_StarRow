//
//  File.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 7/02/24.
//

import Foundation

struct DetailsMovieEntity {
    var id: Int
    var name: String
    var backDrop: String
    var poster: String
    var genrers: [Genre]
    var description: String
    var releaseDate: String
    var voteAverage: Double
    
    init(id: Int, name: String, backDrop: String, poster: String, genrers: [Genre], description: String, releaseDate: String, voteAverage: Double) {
        self.id = id
        self.name = name
        self.backDrop = backDrop
        self.poster = poster
        self.genrers = genrers
        self.description = description
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
    
    init(movieDetailsApi: DetailsWS.MovieDTO) {
        self.id = movieDetailsApi.id ?? 0
        self.name = movieDetailsApi.title ?? ""
        self.poster = movieDetailsApi.posterPath ?? ""
        self.backDrop = movieDetailsApi.backdropPath ?? ""
        self.description = movieDetailsApi.overview ?? ""
        self.genrers = movieDetailsApi.genres ?? []
        self.releaseDate = movieDetailsApi.releaseDate ?? ""
        self.voteAverage = movieDetailsApi.voteAverage ?? 0
    }
}
