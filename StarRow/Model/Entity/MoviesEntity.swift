import Foundation

struct MoviesEntity: Equatable {
    var id: Int = 0
    var name: String
    var poster: String
    var releaseDate: String
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
        self.name = movieApi.title ?? ""
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
    
    static func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        let dayName = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].capitalized
        let day = Calendar.current.component(.day, from: date)
        let month = dateFormatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        let year = Calendar.current.component(.year, from: date)
        
        return "\(dayName) \(day) de \(month) del \(year)"
    }
    
    static func formatShortDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        let day = Calendar.current.component(.day, from: date)
        let month = dateFormatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        let year = Calendar.current.component(.year, from: date)
        
        return "\(day) \(month) \(year)"
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


