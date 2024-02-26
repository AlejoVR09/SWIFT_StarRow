//
//  MoviesViewController.swift
//  StarRow
//
//  Created by Alej andro Vanegas Rondon on 23/01/24.
//

import UIKit


class MoviesViewController: UIViewController {

    private var strategy: MoviesListViewStrategy
    private let moviesView: MoviesView
    
    private var idMovieSelected: Int = 0
    
    init(moviesView: MoviesView, strategy: MoviesListViewStrategy) {
        self.moviesView = moviesView
        self.strategy = strategy
        super.init(nibName: nil, bundle: nil)
        self.moviesView.adapter.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = moviesView
        moviesView.setUpAdapter()
        moviesView.delegate = self
        self.strategy.pullToRefresh?()
        self.strategy.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.strategy.reloadView?(){}
    }
}

extension MoviesViewController: AdapterDelegate{
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath) {
        self.moviesView.closeKeyboard()
        self.navigationController?.show(DetailsViewController(detailsView: DetailsView(), delegate: self , id: self.moviesView.adapter.data[indexPath.item].id), sender: nil)
    }
}

extension MoviesViewController: DetailsViewControllerDelegate {
    func didTapToAdd(_ detailViewController: DetailsViewController, theMovie movie: DetailsMovieEntity) {
        self.strategy.reloadView?() {
            self.moviesView.searchBarAdapter.filteredMovies.isEmpty && !self.moviesView.searchBarAdapter.movies.contains() { movieToSeach in movieToSeach.name == movie.name} ? self.moviesView.searchBarAdapter.movies.append(contentsOf: [movie].toMoviesEntityFromDetailsMovie) : {self.moviesView.searchBarAdapter.filteredMovies.append(contentsOf: [movie].toMoviesEntityFromDetailsMovie);self.moviesView.searchBarAdapter.movies.append(contentsOf: [movie].toMoviesEntityFromDetailsMovie)}()
        }
    }
    
    func didTapRemove(_ detailViewController: DetailsViewController, theMovie idMovie: Int) {
        self.strategy.reloadView?() {
            self.moviesView.searchBarAdapter.movies = self.moviesView.searchBarAdapter.movies.filter { movie in
                movie.id != idMovie}
            self.moviesView.searchBarAdapter.filteredMovies = self.moviesView.searchBarAdapter.filteredMovies.filter { movie in
                movie.id != idMovie}
        }
    }
}

extension MoviesViewController: MoviesViewDelegate{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView) {
        self.strategy.fetch()
    }
}
