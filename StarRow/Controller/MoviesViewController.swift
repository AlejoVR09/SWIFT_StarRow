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
    
    var arrayMoviesOfApi: [MoviesWS.Response.Movie] = []
    var arrayMoviesOfCoreData: [MovieCoreData] = []
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
                self.moviesView?.moviesApi = arrayMovies
                self.apiAdapter.apiData = arrayMovies
                self.arrayMoviesOfApi = arrayMovies
            }
        }
    }
    
    func fetchMoviesFromCoreData(){
        do{
            let movies = try self.context.fetch(MovieCoreData.fetchRequest())
            self.moviesView?.moviesCoreData = movies
            self.arrayMoviesOfCoreData = movies
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
            self.moviesView?.setCollectionView(collectionViewbuilderApi, withCustomCell: "CustomMovieCell", OfCollectionViewCell: "CustomCollectionViewCell")
        }
        else{
            fetchMoviesFromCoreData()
            let collectionViewDirector = MoviesCollectionViewDirector()
            let collectionViewbuilderCoreData = collectionViewDirector.createCoreDataCollectionView(withDelegate: coreDataAdapter, dataSource: coreDataAdapter, flowLayout: coreDataAdapter)
            self.moviesView?.setCollectionView(collectionViewbuilderCoreData, withCustomCell: "FavoriteCell", OfCollectionViewCell: "FavoriteCollectionViewCell")
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
        self.idMovieSelected = arrayMoviesOfApi[indexPath.item].id ?? 0
        self.performSegue(withIdentifier: "DetailsViewController", sender: self)
    }
}

extension MoviesViewController: coreDataAdapterDelegate {
    func didSelectButtonToDelete(_ coreDataAdapter: CoreDataCollectionViewAdapter, indexPath: IndexPath) {
        self.context.delete(self.arrayMoviesOfCoreData[indexPath.item])
        fetchMoviesFromCoreData()
    }
}

extension MoviesViewController: MoviesViewDelegate{
    func moviesViewToSearchMovies(_ moviesView: MoviesView, withText: String) {
        guard
            let index = self.tabBarController?.selectedIndex
        else {
            return
        }
        if index == 0 {
            let newArrayOfMoviesFromApi =  self.arrayMoviesOfApi.filter(){ movie in
               return movie.title!.contains(withText)
           }
            if newArrayOfMoviesFromApi.isEmpty {
                fetchMoviesFromApi()
            }
            else{
                self.apiAdapter.apiData = newArrayOfMoviesFromApi
                self.moviesView?.moviesApi = newArrayOfMoviesFromApi
                self.arrayMoviesOfApi = newArrayOfMoviesFromApi
            }
        }
        else{
            let newArrayOfMoviesFromCoreData =  self.arrayMoviesOfCoreData.filter(){ movie in
                return movie.originalTitle!.contains(withText)
           }
            if newArrayOfMoviesFromCoreData.isEmpty {
                fetchMoviesFromCoreData()
            }
            else{
                self.moviesView?.moviesCoreData = newArrayOfMoviesFromCoreData
                self.arrayMoviesOfCoreData = newArrayOfMoviesFromCoreData
                self.coreDataAdapter.coreDataObjects = newArrayOfMoviesFromCoreData
            }
        }
    }
}
