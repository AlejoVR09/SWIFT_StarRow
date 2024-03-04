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
        self.strategy.reloadView?()
    }
}

extension MoviesViewController: AdapterDelegate{
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath) {
        self.moviesView.closeKeyboard()
        self.navigationController?.show(DetailsViewController(detailsView: DetailsView(), id: self.moviesView.adapter.data[indexPath.item].id), sender: nil)
    }
}

extension MoviesViewController: MoviesViewDelegate{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView) {
        self.strategy.fetch()
    }
}
