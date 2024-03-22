//
//  MoviesCoreData.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 21/03/24.
//

import Foundation
import UIKit

struct MoviesProvider {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createMovie(id: Int, name: String, poster: String, releaseDate: String) -> MovieCoreData {
        let movie = MovieCoreData(context: self.context)
        movie.idMovie = Double(id)
        movie.originalTitle = name
        movie.posterPath = poster
        movie.releaseDate = releaseDate
        return movie
    }
    
    func retrieveData(currentUser: AppUser?) -> [MovieCoreData]{
        guard let movies = currentUser?.favorites as? Set<MovieCoreData> else { return [] }
        return Array(movies)
    }
    
    func deleteMovie(currentUser: AppUser?, movieSelected: DetailsMovieEntity){
        let moviesSaved = retrieveData(currentUser: currentUser)
        let result = moviesSaved.first { $0.originalTitle == movieSelected.name }
        guard let result = result else { return }
        currentUser?.removeFromFavorites(result)
        do {
            try self.context.save()
        }
        catch{
            print(error)
        }
    }
}
