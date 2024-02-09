//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit
import Kingfisher

class MoviesView: UIView {
    
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var movies: [MoviesWS.Response.Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
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
