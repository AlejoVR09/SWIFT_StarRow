//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit
import Kingfisher

protocol MoviesViewDelegate: AnyObject{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView)
    func moviesView(_ moviesView: MoviesView, didSelectMovie movie: MoviesEntity)
}
// MARK: UI Elements
class MoviesView: UIView{
    weak var delegate: MoviesViewDelegate?
    var adapter: MoviesAdapterProtocol
    var searchBarAdapter: MoviesSearchAdapterProtocol
    
    init(adapter: MoviesAdapterProtocol, searchBarAdapter: MoviesSearchAdapterProtocol) {
        self.adapter = adapter
        self.searchBarAdapter = searchBarAdapter
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = .white
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        self.tapGesture.isEnabled = false
        self.backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        return view
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = UIColor(named: AppConstant.Color.inverseColor)
        activity.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        activity.startAnimating()
        return activity
    }()
    
    private var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "SearchBarPlaceHolder".localized(withComment: "SearchBarPlaceHolderComment".localized())
        searchBar.sizeToFit()
        return searchBar
    }()

    private var tapGesture: UITapGestureRecognizer!
    
    private lazy var pullToRefresh: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pullToRefreshAction(_ :)), for: .valueChanged)
        return refresher
    }()
}
// MARK: obcj methods
extension MoviesView {
    @objc func pullToRefreshAction(_ sender: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.endRefreshing()
            self.searchBar.text = ""
            self.delegate?.moviesViewPullToRefreshApiData(self)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
}
// MARK: Constraints and Methods
extension MoviesView {
    func setUpAdapters(){
        self.adapter.setUpCollectionView(self.movieCollectionView)
        self.searchBarAdapter.setUpSearchBar(self.searchBar)
        self.delegate?.moviesViewPullToRefreshApiData(self)
        
        self.adapter.didSelectHandler { movie in
            self.delegate?.moviesView(self, didSelectMovie: movie)
        }
        
        self.searchBarAdapter.didFilterHandler { result in
            self.reloadCollectionViewData(result)
        }
    }
    
    private func reloadCollectionViewData(_ newArrayMovies: [Any]){
        self.adapter.data = newArrayMovies
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
    
    func updateCollectionView(_ newArrayMovies: [MoviesEntity]){
        self.searchBarAdapter.movies = newArrayMovies
        reloadCollectionViewData(newArrayMovies)
    }
    
    func addPullToRefresh(){
        self.movieCollectionView.alwaysBounceVertical = true
        self.movieCollectionView.bounces = true
        self.movieCollectionView.refreshControl = pullToRefresh
    }
    
    func scrollToTop(){
        self.movieCollectionView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func closeKeyboard(){
        self.searchBar.resignFirstResponder()
    }
    
    func cleanSearchBar(){
        self.searchBar.text = ""
    }
}

extension MoviesView {
    private func setConstraints(){
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
        
        addSubview(movieCollectionView)
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
