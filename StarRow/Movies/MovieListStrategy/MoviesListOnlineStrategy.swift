//
//  MoviesListOnlineStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation
import UIKit

class MoviesListOnlineStrategy: MoviesListViewStrategy {
    lazy var moviesWS = MoviesWS()
    let moviesView: MoviesView
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    func loadMoviesList() {
        moviesView.setCollectionView(MoviesView.buildOnline(moviesView: moviesView))
    }
    
    func fetch(){
        self.moviesWS.execute(){ arrayMovies in
            self.moviesView.movies = arrayMovies.toMovieEntityFromApi
            self.moviesView.searchBarAdapter.movies = arrayMovies.toMovieEntityFromApi
        }
    }
}
