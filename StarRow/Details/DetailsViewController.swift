//
//  DetailsViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var id: Int
    var detailsView: DetailsView
    var movieSelected: DetailsMovieEntity!
    
    lazy var detailWS = DetailsWS()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(detailsView: DetailsView, id: Int) {
        self.detailsView = detailsView
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailsView
        
        self.navigationItem.title = "Movie Details"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.detailWS.execute(id: self.id){ movie in
            DispatchQueue.main.async {
                self.movieSelected = DetailsMovieEntity(movieDetailsApi: movie)
                self.detailsView.setUpView(data: self.movieSelected)
                self.navigationItem.rightBarButtonItem = self.verifyMovieInCoreData()
            }
        }
    }
    
    @objc private func didButtonPressedToAddFavorite(){
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        self.navigationItem.rightBarButtonItem?.action = #selector(didButtonPressedToDeleteFromFavorites)
        
        let movie = MovieCoreData(context: self.context)
        movie.idMovie = Double(self.movieSelected.id)
        movie.originalTitle = self.movieSelected.name
        movie.posterPath = self.movieSelected.poster
        movie.releaseDate = self.movieSelected.releaseDate
        
        do {
            try self.context.save()
        }
        catch{
            print("error saving")
        }
    }
    
    @objc private func didButtonPressedToDeleteFromFavorites(){
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        self.navigationItem.rightBarButtonItem?.action = #selector(didButtonPressedToAddFavorite)
        
        let moviesSaved = self.retrieveData()
        let result = moviesSaved.first { $0.originalTitle == self.movieSelected.name }
        guard let result = result else { return }
        
        self.context.delete(result)
        do {
            try self.context.save()
        }
        catch{
            print("error deleting")
        }
    }

    private func verifyMovieInCoreData() -> UIBarButtonItem {
        let result = self.retrieveData().first{ $0.originalTitle == self.movieSelected?.name }
        return result != nil ? UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(didButtonPressedToDeleteFromFavorites)) : UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didButtonPressedToAddFavorite))
    }
    
    private func retrieveData() -> [MovieCoreData]{
        do{
            let movies = try self.context.fetch(MovieCoreData.fetchRequest())
            return movies
        }
        catch {
            print("There is no favorite movies avaible!")
            return []
        }
    }
}
