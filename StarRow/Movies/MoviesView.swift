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
}

class MoviesView: UIView{
    
    weak var delegate: MoviesViewDelegate?
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
        self.backgroundColor = UIColor(named: "Main")
        setUpAdapter()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private var viewForSearch: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
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
            self.searchBar.text = ""
            self.delegate?.moviesViewPullToRefreshApiData(self)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
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
    }
    
    func setSeachView(){
        self.viewForSearch.isHidden = false
        self.movieCollectionView.isHidden = true
        self.tapGesture.isEnabled = true
    }
    
    func removeSearchView(){
        self.viewForSearch.isHidden = true
        self.movieCollectionView.isHidden = false
        self.tapGesture.isEnabled = false
    }
    
    func setUpAdapter(){
        self.adapter.setUpCollectionView(self.movieCollectionView)
    }
    
    func updateCollectionView(_ newArrayMovies: [MoviesEntity]){
        self.adapter.data = newArrayMovies
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
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
