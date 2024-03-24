//
//  DetailsViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

// MARK: Class declaration
class DetailsViewController: UIViewController {
    private var id: Int
    private var detailsView: DetailsView
    private var movieSelected: DetailsMovieEntity!
    private var currentUser: AppUser?
    private let userRepository = AppUserRepository()
    private let movieRepository = MoviesRepository()
    lazy var detailWS = DetailsWS()
    
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
        self.detailsView.addLoadingView()
        self.navigationItem.title = AppConstant.Translations.movieDetailsTittle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: AppConstant.SystemImageNames.chevronBackward), style: .plain, target: self, action: #selector(getBack))
        self.currentUser = userRepository.retrieveUser(email: UserSession.getCurrentSessionProfile())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.detailWS.execute(id: self.id){ movie in
            DispatchQueue.main.async {
                self.movieSelected = DetailsMovieEntity(movieDetailsApi: movie)
                self.detailsView.setUpView(data: self.movieSelected)
                self.navigationItem.rightBarButtonItem = self.verifyMovieInCoreData()
                self.detailsView.removeLoadingView()
            }
        }
    }
    
    private func verifyMovieInCoreData() -> UIBarButtonItem {
        let result = movieRepository.retrieveData(currentUser: self.currentUser).first{ $0.originalTitle == self.movieSelected?.name }
        return result != nil ? UIBarButtonItem(image: UIImage(systemName: AppConstant.SystemImageNames.starFill), style: .plain, target: self, action: #selector(didButtonPressedToDeleteFromFavorites)) : UIBarButtonItem(image: UIImage(systemName: AppConstant.SystemImageNames.star), style: .plain, target: self, action: #selector(didButtonPressedToAddFavorite))
    }
}

// MARK: Selectors
extension DetailsViewController {
    @objc private func didButtonPressedToAddFavorite(){
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: AppConstant.SystemImageNames.starFill)
        self.navigationItem.rightBarButtonItem?.action = #selector(didButtonPressedToDeleteFromFavorites)
        let movie = movieRepository.createMovie(id: movieSelected.id, name: movieSelected.name, poster: movieSelected.poster, releaseDate: movieSelected.releaseDate)
        userRepository.saveMovieInUser(currentUser: currentUser, movie: movie)
    }
    
    @objc private func didButtonPressedToDeleteFromFavorites(){
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: AppConstant.SystemImageNames.star)
        self.navigationItem.rightBarButtonItem?.action = #selector(didButtonPressedToAddFavorite)
        movieRepository.deleteMovie(currentUser: currentUser, movieSelected: movieSelected)
    }
    
    @objc func getBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Builders
extension DetailsViewController {
    class func buildDetailsViewController(movieId: Int) -> DetailsViewController {
        let view = DetailsView()
        let controller = DetailsViewController(detailsView: view, id: movieId)
        return controller
    }
}
