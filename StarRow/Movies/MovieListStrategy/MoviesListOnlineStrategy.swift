//
//  MoviesListOnlineStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation
import UIKit

// MARK: Class declaration
class MoviesListOnlineStrategy: MoviesListViewStrategy {
    lazy var moviesWS = MoviesWS()
    let moviesView: MoviesView
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    func fetch(){
        self.moviesWS.execute(){[weak self] arrayMovies in
            self?.moviesView.updateCollectionView(arrayMovies.toMovieEntityFromApi)
        }
    }
    
    func pullToRefresh() {
        self.moviesView.addPullToRefresh()
    }
}
