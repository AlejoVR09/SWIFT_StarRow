//
//  MoviesViewController.swift
//  StarRow
//
//  Created by Alej andro Vanegas Rondon on 23/01/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var moviesView: MoviesView? {
        self.view as? MoviesView
    }
    
    let detailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsView")
    
    lazy var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesView?.delegate = self
        movieManager.delegate = self
        movieManager.fetchMovies()
        print("hola")
        guard
            let a = self.navigationController?.viewControllers
        else{
            return
        }
        for i in a {
            print(i)
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

extension MoviesViewController: MoviesViewDelegate{
    func didButtonPressedToDetails(moviesView: MoviesView) {
        self.navigationController?.show(detailsController, sender: nil)
    }
    
    
}

extension MoviesViewController: MovieManagerDelegate {
    func didUpdateMovie(movies: [MovieModel]) {
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
