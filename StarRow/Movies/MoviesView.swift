//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit
import Kingfisher

protocol MoviesViewDelegate{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView)
}

class MoviesView: UIView {
    
    var delegate: MoviesViewDelegate?
    var adapter: AdapterProtocol
    var searchBarAdapter: MovieSearchAdapter
    
    init(adapter: AdapterProtocol, searchBarAdapter: MovieSearchAdapter) {
        self.adapter = adapter
        self.searchBarAdapter = searchBarAdapter
        self.searchBar.delegate = self.searchBarAdapter
        
        
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = .white
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        self.searchBarAdapter.moviesView = self
        self.tapGesture.isEnabled = false
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private var viewForSearch: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var labelForSearch = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cannot find searched element/s"
        return label
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private lazy var pullToRefresh: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pullToRefreshAction(_ :)), for: .valueChanged)
        return refresher
    }()
    
    @objc func pullToRefreshAction(_ sender: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.endRefreshing()
            self.delegate?.moviesViewPullToRefreshApiData(self)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    var movies: [MoviesEntity] = [] {
        didSet{
            DispatchQueue.main.async {
                self.adapter.data = self.movies
                self.updateCollectionView(self.movies)
            }
        }
    }
    
    func updateCollectionView(_ newArrayMovies: [MoviesEntity]){
        let contentOffset = self.movieCollectionView.contentOffset
        self.movieCollectionView.reloadData()
        self.movieCollectionView.layoutIfNeeded()
        self.movieCollectionView.setContentOffset(contentOffset, animated: false)
    }
    
    func clearSearchBar(){
        self.searchBar.text = ""
    }
    
    private func setConstraints(){
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    func setCollectionView(_ collectionViewBuilder: UICollectionView) {
        movieCollectionView = collectionViewBuilder
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieCollectionView)
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    func setSeachView(){
        addSubview(viewForSearch)
        NSLayoutConstraint.activate([
            viewForSearch.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            viewForSearch.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewForSearch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            viewForSearch.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        self.viewForSearch.addSubview(labelForSearch)
        NSLayoutConstraint.activate([
            labelForSearch.centerYAnchor.constraint(equalTo: viewForSearch.centerYAnchor, constant: 0),
            labelForSearch.centerXAnchor.constraint(equalTo: viewForSearch.centerXAnchor, constant: 0)
        ])
        
        self.tapGesture.isEnabled = true
    }
    
    func removeSearchView(){
        self.viewForSearch.removeFromSuperview()
        self.tapGesture.isEnabled = false
    }
}

extension MoviesView {
    class func buildOnline(moviesView: MoviesView) -> UICollectionView{
        let collectionViewDirector = MoviesCollectionViewDirector()
        let collectionView = collectionViewDirector.createAPICollectionView(withDelegate: moviesView.adapter as! UICollectionViewDelegate, dataSource: moviesView.adapter as! UICollectionViewDataSource, flowLayout: moviesView.adapter as! UICollectionViewDelegateFlowLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = moviesView.pullToRefresh
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }
    
    class func buildLocal(moviesView: MoviesView) -> UICollectionView{
        let collectionViewDirector = MoviesCollectionViewDirector()
        let collectionView = collectionViewDirector.createCoreDataCollectionView(withDelegate: moviesView.adapter as! UICollectionViewDelegate, dataSource: moviesView.adapter as! UICollectionViewDataSource, flowLayout: moviesView.adapter as! UICollectionViewDelegateFlowLayout)
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
}
