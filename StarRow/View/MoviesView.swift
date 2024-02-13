//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit
import Kingfisher

protocol MoviesViewDelegate{
    func moviesViewToSearchMovies(_ moviesView: MoviesView, withText: String)
}

class MoviesView: UIView {
    var delegate: MoviesViewDelegate?
    
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var moviesApi: [MoviesWS.Response.Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    var moviesCoreData: [MovieCoreData] = [] {
        didSet{
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.searchBar.delegate = self
    }
    
    func setCollectionView(_ collectionViewBuilder: UICollectionView, withCustomCell: String, OfCollectionViewCell: String) {
        movieCollectionView = collectionViewBuilder
        addSubview(movieCollectionView)
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        movieCollectionView.register(UINib(nibName: OfCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: withCustomCell)
    }
    
    
}

extension MoviesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.moviesViewToSearchMovies(self, withText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.endEditing(true)
    }
}
