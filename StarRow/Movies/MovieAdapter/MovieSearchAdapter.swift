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
    
    override init() {
        super.init()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredMovies = self.movies.filter(
            { movie in
                movie.name.lowercased().contains(searchText.lowercased())
            }
        )
        self.filteredMovies.isEmpty ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
        self.moviesView?.movies = filteredMovies
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.filteredMovies.isEmpty ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        (self.filteredMovies.isEmpty  && searchBar.text != "") ? self.moviesView?.setSeachView() : self.moviesView?.removeSearchView()
        searchBar.text == "" ? {self.moviesView?.movies = self.movies}() : {self.moviesView?.movies = filteredMovies}()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
