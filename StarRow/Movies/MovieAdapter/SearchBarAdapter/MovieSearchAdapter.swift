//
//  MovieSearchAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 16/02/24.
//

import Foundation
import UIKit

protocol MoviesSearchAdapterProtocol: AnyObject {
    var movies: [MoviesEntity] { get set }
    func setUpSearchBar(_ searchBar: UISearchBar)
    func didFilterHandler(_ handler: @escaping (_ movie: [MoviesEntity]) -> Void)
}

class MovieSearchAdapter: NSObject, MoviesSearchAdapterProtocol {
    var movies: [MoviesEntity] = []
    private var didFilter: ((_ movie: [MoviesEntity]) -> Void)?
    private unowned var adapted: UISearchBar?
    
    func setUpSearchBar(_ searchBar: UISearchBar){
        searchBar.delegate = self
        self.adapted = searchBar
    }
    
    func didFilterHandler(_ handler: @escaping (_ movie: [MoviesEntity]) -> Void){
        self.didFilter = handler
    }
}

extension MovieSearchAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let loweredText = searchText.lowercased()
        var arrayResult: [MoviesEntity] = []
        if loweredText.isEmpty {
            arrayResult = movies
        }
        else{
            arrayResult = self.movies.filter({ movie in movie.name.lowercased().contains(loweredText) })
        }
        
        self.didFilter?(arrayResult)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
