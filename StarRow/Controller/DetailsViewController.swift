//
//  DetailsViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class DetailsViewController: UIViewController {

    var id: Int?
    var movieSelected: DetailsWS.Movie?
    
    var detailsView: DetailsView? {
        self.view as? DetailsView
    }
    
    lazy var detailWS = DetailsWS()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie Details"
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "In premier", style: .done, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard
            let correctId = self.id
        else {
            return
        }
        self.detailWS.id = correctId
        self.detailWS.execute(){ movie in
            
            let movieDTO = DetailsMovieDTO(backDrop: movie.backdropPath ?? "", poster: movie.posterPath ?? "", genrers: movie.genres ?? [], description: movie.overview ?? "", releaseDate: movie.releaseDate ?? "")
            DispatchQueue.main.async { [self] in
                self.detailsView?.setUpView(data: movieDTO)
                self.movieSelected = movie
                if self.verifyMovieInCoreData(){
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: (#selector(didButtonPressedToAddFavorite)))
                }
                else{
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: (#selector(didButtonPressedToAddFavorite)))
                }
            }
        }
    }
    
    @objc private func didButtonPressedToAddFavorite(){
        if !verifyMovieInCoreData(){
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            let movie = MovieCoreData(context: self.context)
            movie.originalTitle = self.movieSelected?.title
            movie.posterPath = self.movieSelected?.posterPath
            movie.releaseDate = self.movieSelected?.releaseDate
            do {
                try self.context.save()
            }
            catch{
                print("error saving")
            }
        }
        else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            let moviesSaved = self.retrieveData()
            for i in moviesSaved {
                if i.originalTitle == self.movieSelected?.title {
                    self.context.delete(i)
                }
            }
            do {
                try self.context.save()
            }
            catch{
                print("error deleting")
            }
        }
    }
    
    private func verifyMovieInCoreData() -> Bool{
        let moviesSaved = self.retrieveData()
        
        for i in moviesSaved {
            if i.originalTitle == self.movieSelected?.title {
                return true
            }
        }
        return false
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
