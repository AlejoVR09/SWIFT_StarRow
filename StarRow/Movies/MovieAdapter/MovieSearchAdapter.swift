//
//  MovieSearchAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 16/02/24.
//

import Foundation
import UIKit

class MovieSearchAdapter:NSObject, UISearchBarDelegate {
    
    var moviesView: MoviesView?
    var movies: [MoviesEntity] = []
    var filteredMovies: [MoviesEntity] = []
    var isLookingFor: Bool = false
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredMovies = self.movies.filter({ movie in movie.name.lowercased().contains(searchText.lowercased()) })
        self.filteredMovies.isEmpty ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
        self.moviesView?.updateCollectionView(filteredMovies)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isLookingFor = searchBar.text != ""
        self.filteredMovies.isEmpty ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isLookingFor = searchBar.text != ""
        self.filteredMovies.isEmpty  && self.isLookingFor ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
        !self.isLookingFor ? self.moviesView?.updateCollectionView(self.movies) : self.moviesView?.updateCollectionView(filteredMovies)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
