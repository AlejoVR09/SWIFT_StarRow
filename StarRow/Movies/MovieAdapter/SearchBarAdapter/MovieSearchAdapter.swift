//
//  MovieSearchAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 16/02/24.
//

import Foundation
import UIKit

// MARK: Protocol
protocol MoviesSearchAdapterProtocol: AnyObject {
    var movies: [MoviesEntity] { get set }
    func setUpSearchBar(_ searchBar: UISearchBar)
    func didFilterHandler(_ handler: @escaping (_ result: [Any]) -> Void)
}

// MARK: Class declaration
class MovieSearchAdapter: NSObject, MoviesSearchAdapterProtocol {
    var movies: [MoviesEntity] = []
    private var didFilter: ((_ movie: [Any]) -> Void)?
    private unowned var adapted: UISearchBar?
    
    func setUpSearchBar(_ searchBar: UISearchBar){
        searchBar.delegate = self
        self.adapted = searchBar
    }
    
    func didFilterHandler(_ handler: @escaping (_ result: [Any]) -> Void){
        self.didFilter = handler
    }
}

// MARK: Delegate
extension MovieSearchAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let loweredText = searchText.lowercased()
        var arrayResult: [Any] = []
        if loweredText.isEmpty {
            arrayResult = movies
        }
        else{
            arrayResult = self.movies.filter({ $0.name.lowercased().contains(loweredText) })
            arrayResult = !arrayResult.isEmpty ? arrayResult : ["""
            \(AppConstant.Translations.elementsNotFound)
            \(searchText)
            """]
        }
        self.didFilter?(arrayResult)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
