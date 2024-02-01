//
//  MoviesViewController.swift
//  StarRow
//
//  Created by Alej andro Vanegas Rondon on 23/01/24.
//

import UIKit


    class MoviesViewController: UIViewController {
        
        var array: [MoviesWS.Response.Movie] = []
        
        var moviesView: MoviesView? {
            return self.view as? MoviesView
        }
        
        
        
        lazy var moviesWS = MoviesWS()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            moviesView?.delegate = self
            self.fetchMovies()
        }

        func fetchMovies(){
            self.moviesWS.execute(){ arrayMovies in
                self.moviesView?.movies = arrayMovies
                self.array = arrayMovies
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
        let detailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsView")
        self.navigationController?.show(detailsController, sender: nil)
    }
}
