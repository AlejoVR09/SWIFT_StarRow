//
//  MovieManager.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovie(movies: [MovieModel])
    func didFailWithError(error: Error)
}

struct MovieManager {
    var delegate: MovieManagerDelegate?
    
    let url: String = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c"
    
    func fetchMovies(){
        perfomRequest(with: url)
    }
    
    func perfomRequest(with urlString: String){
        
        if let url = URL(string: urlString) {
            print("hola")
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ data, response, error in
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    if let movie = self.parseJSON(movieData: data){
                        print(movie)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(movieData: Data) -> [MovieModel]?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(MovieData.self, from: movieData)
            let movies = decodeData.results?.map{
                MovieModel(adult: $0.adult ?? false, backdropPath: $0.backdropPath ?? "", genreIDS: $0.genreIDS ?? [], id: $0.id ?? 0, originalLanguage: $0.originalLanguage ?? OriginalLanguage(rawValue: "es")!, originalTitle: $0.originalTitle ?? "", overview: $0.overview ?? "", popularity: $0.popularity ?? 0.0, posterPath: $0.posterPath ?? "", releaseDate: $0.releaseDate ?? "", title: $0.title ?? "")
            }
            return movies
        }catch {
            return nil
        }
    }
}
