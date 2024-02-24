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
        do{
            let movies = try self.context.fetch(MovieCoreData.fetchRequest())
            self.moviesView.searchBarAdapter.movies = movies.toMovieEntityFromCoreData
            self.moviesView.updateCollectionView(movies.toMovieEntityFromCoreData)
        }
        catch {
            print("There is no favorite movies avaible!")
        }
    }
    
    func reloadView() {
        self.moviesView.searchBarAdapter.filteredMovies.isEmpty ? self.fetch() : {self.moviesView.updateCollectionView(self.moviesView.searchBarAdapter.filteredMovies)}()
    }
}
