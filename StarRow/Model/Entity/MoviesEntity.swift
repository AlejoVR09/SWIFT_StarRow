import Foundation

struct MoviesEntity: Equatable, Hashable {
    var id: Int = 0
    var name: String = ""
    var poster: String = ""
    var releaseDate: String = ""
    var voteAverage: Double = 0
    
    init(id: Int, name: String, poster: String, releaseDate: String, voteAverage: Double) {
        self.id = id
        self.name = name
        self.poster = poster
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
    
    init(movieApi: MoviesWS.Response.MovieDTO) {
        self.id = movieApi.id ?? 0
        self.name = movieApi.originalTitle ?? ""
        self.poster = movieApi.posterPath ?? ""
        self.releaseDate = movieApi.releaseDate ?? ""
        self.voteAverage = movieApi.voteAverage ?? 0
    }
    
    init(moviesCoreData: MovieCoreData) {
        self.id = Int(moviesCoreData.idMovie)
        self.name = moviesCoreData.originalTitle ?? ""
        self.poster = moviesCoreData.posterPath ?? ""
        self.releaseDate = moviesCoreData.releaseDate ?? ""
    }
}

extension Array where Element == MoviesWS.Response.MovieDTO {
    var toMovieEntityFromApi: [MoviesEntity] {
        self.map({ MoviesEntity(movieApi: $0) })
    }
}

extension Array where Element == MovieCoreData {
    var toMovieEntityFromCoreData: [MoviesEntity] {
        self.map({ MoviesEntity(moviesCoreData: $0) })
    }
}

extension Set where Element == MovieCoreData {
    var toMovieEntityFromCoreData: [MoviesEntity] {
        self.map({ MoviesEntity(moviesCoreData: $0) })
    }
}
