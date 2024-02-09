//
//  File.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 7/02/24.
//

import Foundation

struct DetailsMovieDTO {
    var backDrop: String = ""
    var poster: String = ""
    var genrers: [Genre] = []
    var description: String = ""
    var releaseDate: String = ""
    
    init(backDrop: String, poster: String, genrers: [Genre], description: String, releaseDate: String) {
        self.backDrop = backDrop
        self.poster = poster
        self.genrers = genrers
        self.description = description
        self.releaseDate = releaseDate
    }
    
    init(){}
}
