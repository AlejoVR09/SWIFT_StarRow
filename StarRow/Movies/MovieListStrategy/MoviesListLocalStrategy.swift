//
//  MoviesListLocalStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation
import UIKit

// MARK: Class declaration
class MoviesListLocalStrategy: MoviesListViewStrategy {
    private let moviesView: MoviesView
    private let userRepository = AppUserRepository()
    private let movieRepository = MoviesRepository()
    
    init(moviesView: MoviesView) {
        self.moviesView = moviesView
    }
    
    func fetch(){
        let user = userRepository.getByEmail(email: UserSession.getCurrentSessionProfile())
        guard let user = user else { return }
        self.moviesView.updateCollectionView(movieRepository.getAll(currentUser: user).toMovieEntityFromCoreData.sorted() { $0.name < $1.name })
    }
    
    func reloadView() {
        self.fetch()
        self.moviesView.cleanSearchBar()
    }
}
