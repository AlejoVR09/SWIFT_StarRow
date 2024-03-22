//
//  MoviesListLocalStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation
import UIKit

class MoviesListLocalStrategy: MoviesListViewStrategy {
    
    let moviesView: MoviesView
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    func fetch(){
        let user = retrieveUser(email: UserSession.getCurrentSessionProfile())
        guard let movies = user?.favorites as? Set<MovieCoreData> else { return }
        self.moviesView.updateCollectionView((Array(movies).toMovieEntityFromCoreData).sorted() { $0.name < $1.name })
    }
    
    func reloadView() {
        self.fetch()
        self.moviesView.cleanSearchBar()
    }
    
    func retrieveUser(email: String) -> AppUser? {
        let moviesSaved = self.retrieveUserData()
        let result = moviesSaved.first { $0.email == email }
        guard let result = result else { return nil }
        return result
    }
    
    private func retrieveUserData() -> [AppUser]{
        do{
            let movies = try self.context.fetch(AppUser.fetchRequest())
            return movies
        }
        catch {
            return []
        }
    }
}
