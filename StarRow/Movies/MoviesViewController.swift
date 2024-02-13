//
//  MoviesViewController.swift
//  StarRow
//
//  Created by Alej andro Vanegas Rondon on 23/01/24.
//

import UIKit


class MoviesViewController: UIViewController, UICollectionViewDelegate {
    
    
    private var apiAdapter: APICollectionViewAdapter = APICollectionViewAdapter(apiData: [])
    private var coreDataAdapter: CoreDataCollectionViewAdapter = CoreDataCollectionViewAdapter(coreDataObjects: [])
    
    var idMovieSelected: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moviesView: MoviesView? {
        return self.view as? MoviesView
    }
    lazy var moviesWS = MoviesWS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiAdapter.delegate = self
        coreDataAdapter.delegate = self
        moviesView?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedTabView()
    }

    func fetchMoviesFromApi(){
        self.moviesWS.execute(){ arrayMovies in
            DispatchQueue.main.async {
                print(1)
                self.moviesView?.moviesApi = arrayMovies
                self.apiAdapter.apiData = arrayMovies
            }
        }
    }
    
    func fetchMoviesFromCoreData(){
        do{
            let movies = try self.context.fetch(MovieCoreData.fetchRequest())
            self.moviesView?.moviesCoreData = movies
            self.coreDataAdapter.coreDataObjects = movies
        }
        catch {
            print("There is no favorite movies avaible!")
        }
    }
    
    func selectedTabView(){
        guard
            let index = self.tabBarController?.selectedIndex
        else {
            return
        }
        if index == 0 {
            fetchMoviesFromApi()
            let collectionViewDirector = MoviesCollectionViewDirector()
            let collectionViewbuilderApi = collectionViewDirector.createAPICollectionView(withDelegate: apiAdapter, dataSource: apiAdapter, flowLayout: apiAdapter)
            self.moviesView?.setCollectionView(collectionViewbuilderApi, ofTabView: index)
        }
        else{
            fetchMoviesFromCoreData()
            let collectionViewDirector = MoviesCollectionViewDirector()
            let collectionViewbuilderCoreData = collectionViewDirector.createCoreDataCollectionView(withDelegate: coreDataAdapter, dataSource: coreDataAdapter, flowLayout: coreDataAdapter)
            self.moviesView?.setCollectionView(collectionViewbuilderCoreData, ofTabView: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            if let destination = segue.destination as? DetailsViewController{
                destination.id = self.idMovieSelected
            }
        }
    }
}

extension MoviesViewController: apiAdapterDelegate{
    func didSelectMovieToDetails(_ apiAdapter: APICollectionViewAdapter, indexPath: IndexPath) {
        self.idMovieSelected = self.apiAdapter.apiData[indexPath.item].id ?? 0
        self.performSegue(withIdentifier: "DetailsViewController", sender: self)
    }
}

extension MoviesViewController: coreDataAdapterDelegate {
    func didSelectButtonToDelete(_ coreDataAdapter: CoreDataCollectionViewAdapter, indexPath: IndexPath) {
        self.context.delete(self.coreDataAdapter.coreDataObjects[indexPath.item])
        do{
            try self.context.save()
            self.moviesView?.clearSearchBar()
            fetchMoviesFromCoreData()
        }
        catch{
            print("error deleting from favorite list")
        }
        
    }
}

extension MoviesViewController: MoviesViewDelegate{
    func moviesViewPullToRefreshApiData(_ moviesView: MoviesView) {
        fetchMoviesFromApi()
    }
    
    func moviesViewToSearchMovies(_ moviesView: MoviesView, withText: String) {
        guard
            let index = self.tabBarController?.selectedIndex
        else {
            return
        }
        if index == 0 {
            let newArrayOfMoviesFromApi =  self.apiAdapter.apiData.filter(){ movie in
               return movie.title!.contains(withText)
           }
            if newArrayOfMoviesFromApi.isEmpty {
                fetchMoviesFromApi()
            }
            else{
                self.apiAdapter.apiData = newArrayOfMoviesFromApi
                self.moviesView?.moviesApi = newArrayOfMoviesFromApi
            }
        }
        else{
            let newArrayOfMoviesFromCoreData =  self.coreDataAdapter.coreDataObjects.filter(){ movie in
                return movie.originalTitle!.contains(withText)
           }
            if newArrayOfMoviesFromCoreData.isEmpty {
                fetchMoviesFromCoreData()
            }
            else{
                self.moviesView?.moviesCoreData = newArrayOfMoviesFromCoreData
                self.coreDataAdapter.coreDataObjects = newArrayOfMoviesFromCoreData
            }
        }
    }
}
