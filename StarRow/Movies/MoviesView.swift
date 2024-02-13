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
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView)
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
    
    func clearSearchBar(){
        self.searchBar.text = ""
    }
    
    func setCollectionView(_ collectionViewBuilder: UICollectionView, ofTabView: Int) {
        movieCollectionView = collectionViewBuilder
        addSubview(movieCollectionView)
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        if ofTabView == 0 {
            movieCollectionView.alwaysBounceVertical = true
            movieCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomMovieCell")
            movieCollectionView.alwaysBounceVertical = true
            let refresher = UIRefreshControl()
            refresher.addTarget(self, action: #selector(pullToRefreshACtion), for: .valueChanged)
            movieCollectionView.refreshControl = refresher
        }
        else{
            movieCollectionView.alwaysBounceVertical = false
            movieCollectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
        }
    }
    
    @objc func pullToRefreshACtion(){
        self.delegate?.moviesViewPullToRefreshApiData(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.movieCollectionView.refreshControl?.endRefreshing()
        }
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
