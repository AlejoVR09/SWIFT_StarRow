//
//  MovieSearchAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 16/02/24.
//

import Foundation
import UIKit

protocol MoviesSearchAdapterProtocol: AnyObject {
    var data: [MoviesEntity] { get set }
    func setUpSearchBar(_ collectionView: UICollectionView)
    func didFilterHandler(_ handler: @escaping (_ movie: [MoviesEntity]) -> Void)
}

class MovieSearchAdapter: NSObject {
    var moviesView: MoviesView?
    var movies: [MoviesEntity] = []
    var filteredMovies: [MoviesEntity] = []
    var isLookingFor: Bool = false
    private unowned var adapted: UISearchBar?
    
    func setUpSearchBar(_ searchBar: UISearchBar){
        searchBar.delegate = self
        self.adapted = searchBar
    }
}

extension MovieSearchAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let loweredText = searchText.lowercased()
        self.filteredMovies = self.movies.filter({ movie in movie.name.lowercased().contains(loweredText) })
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
