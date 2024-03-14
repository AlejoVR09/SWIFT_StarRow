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
            self.moviesView.updateCollectionView((movies.toMovieEntityFromCoreData).sorted() { $0.name < $1.name })
        }
        catch {
            print("There is no favorite movies avaible!")
        }
    }
    
    func reloadView() {
        self.fetch()
        self.moviesView.cleanSearchBar()
    }
}
