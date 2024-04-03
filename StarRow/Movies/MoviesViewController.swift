//
//  MoviesViewController.swift
//  StarRow
//
//  Created by Alej andro Vanegas Rondon on 23/01/24.
//

import UIKit

// MARK: Class declaration
class MoviesViewController: UIViewController {
    private var strategy: MoviesListViewStrategy
    private let moviesView: MoviesView
    
    init(moviesView: MoviesView, strategy: MoviesListViewStrategy) {
        self.moviesView = moviesView
        self.strategy = strategy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = moviesView
        moviesView.setUpAdapters()
        moviesView.delegate = self
        self.strategy.pullToRefresh?()
        self.strategy.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.strategy.reloadView?()
    }
}

// MARK: View Delegate
extension MoviesViewController: MoviesViewDelegate{
    func moviesView(_ moviesView: MoviesView, didSelectMovie movie: MoviesEntity) {
        self.moviesView.closeKeyboard()
        self.navigationController?.show(DetailsViewController.buildDetailsViewController(movieId: movie.id), sender: nil)
    }
    
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView) {
        self.strategy.fetch()
    }
}

// MARK: Builders
extension MoviesViewController {
    static func buildOnline() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: OnlineAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListOnlineStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)

        controller.tabBarItem.image = UIImage(systemName: AppConstant.SystemImageNames.squareSplit)
        controller.tabBarItem.selectedImage = UIImage(systemName: AppConstant.SystemImageNames.squareSplitFill)
        controller.tabBarItem.title = AppConstant.Translations.moviesTab
        return controller
    }
    
    static func buildLocal() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: LocalAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListLocalStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)
        
        controller.tabBarItem.image = UIImage(systemName: AppConstant.SystemImageNames.star)
        controller.tabBarItem.selectedImage = UIImage(systemName: AppConstant.SystemImageNames.starFill)
        controller.tabBarItem.title = AppConstant.Translations.FavoritesTab
        return controller
    }
}
