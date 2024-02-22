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
        moviesView.delegate = self
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func fetchMovies(){
        self.strategy.loadMoviesList()
        self.strategy.fetch()
    }
}

extension MoviesViewController: AdapterDelegate{
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath) {
        self.navigationController?.show(DetailsViewController(detailsView: DetailsView(), delegate: self, id: self.moviesView.adapter.data[indexPath.item].id), sender: nil)
    }
}

extension MoviesViewController: DetailsViewControllerDelegate {
    func detailsViewController(_ detailsViewController: DetailsViewController) {
        
    }
}

extension MoviesViewController: MoviesViewDelegate{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView) {
        self.strategy.fetch()
    }
}
