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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: (#selector(didButtonPressedToAddFavorite)))
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "In premier", style: .done, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard
            let correctId = self.id
        else {
            return
        }
        self.detailWS.id = correctId
        self.detailWS.execute(){ movie in
            
            let movieDTO = DetailsMovieDTO(backDrop: movie.backdropPath ?? "", poster: movie.posterPath ?? "", genrers: movie.genres ?? [], description: movie.overview ?? "", releaseDate: movie.releaseDate ?? "")
            DispatchQueue.main.async {
                self.detailsView?.setUpView(data: movieDTO)
                self.movieSelected = movie
            }
        }
    }
    
    @objc private func didButtonPressedToAddFavorite(){
        let moviesSaved = self.retrieveData()
        for i in moviesSaved {
            print(i)
        }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
