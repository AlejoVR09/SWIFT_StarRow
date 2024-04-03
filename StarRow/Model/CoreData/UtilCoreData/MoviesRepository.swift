//
//  MoviesCoreData.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 21/03/24.
//

import Foundation
import UIKit

// MARK: Class Declaration
struct MoviesRepository {
    func getAll(currentUser: AppUser?) -> [MovieCoreData]{
        guard let movies = currentUser?.favorites as? Set<MovieCoreData> else { return [] }
        return Array(movies)
    }
    
    func createMovie(id: Int, name: String, poster: String, releaseDate: String) -> MovieCoreData {
        let movie: MovieCoreData = CoreDataManager.shared.createEntity()
        movie.idMovie = Double(id)
        movie.originalTitle = name
        movie.posterPath = poster
        movie.releaseDate = releaseDate
        return movie
    }
    
    func saveMovie(currentUser: AppUser, movie: MovieCoreData){
        currentUser.addToFavorites(movie)
        CoreDataManager.shared.saveContext()
    }
    
    func deleteMovie(currentUser: AppUser, movieSelected: DetailsMovieEntity){
        let moviesSaved = getAll(currentUser: currentUser)
        let result = moviesSaved.first { $0.originalTitle == movieSelected.name }
        guard let result = result else { return }
        currentUser.removeFromFavorites(result)
        CoreDataManager.shared.saveContext()
    }
}
