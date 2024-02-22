//
//  DetailsWS.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 7/02/24.
//

import Foundation

struct DetailsWS {
    
    func execute(id: Int, completionHandle: @escaping (_ arrayMovies: DetailsWS.MovieDTO) -> Void){
        let url: String = "https://api.themoviedb.org/3/movie/"+String(id)+"?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
        
        guard let url = URL(string: url) else { return }
            
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url){ data, response, error in
            let movie = self.parseJSON(movieData: data)
            completionHandle(movie)
        }
        task.resume()
    }
    
    func parseJSON(movieData: Data?) -> MovieDTO{
        guard let movieData = movieData else { return MovieDTO(adult: false, backdropPath: "", budget: 0, genres: [], homepage: "", id: 0, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", productionCompanies: [], releaseDate: "", revenue: 0, runtime: 0, status: "", tagline: "", title: "", video: false, voteAverage: 0, voteCount: 0)
        }
        
        do{
            let decodeData = try JSONDecoder().decode(MovieDTO.self, from: movieData)
            return decodeData
        }catch {
            return MovieDTO(adult: false, backdropPath: "", budget: 0, genres: [], homepage: "", id: 0, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", productionCompanies: [], releaseDate: "", revenue: 0, runtime: 0, status: "", tagline: "", title: "", video: false, voteAverage: 0, voteCount: 0)
        }
    }
}
