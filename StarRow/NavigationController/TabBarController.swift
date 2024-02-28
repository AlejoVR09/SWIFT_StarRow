import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "AppName"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("logOut", comment: ""),
            style: .plain,
            target: self,
            action: #selector(didButtonPressedLogOut)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        tabBar.backgroundColor = .white
        self.setViewControllers([TabBarController.buildOnline(), TabBarController.buildLocal()], animated: true)
    }
    
    @objc func didButtonPressedLogOut(){
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        self.navigationController?.popViewController(animated: true)
    }
}

extension TabBarController {
    static func buildOnline() -> MoviesViewController {
        let moviesView = MoviesView(adapter: APICollectionViewAdapter(), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListOnlineStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)

        controller.tabBarItem.image = UIImage(systemName: "popcorn")
        controller.tabBarItem.selectedImage = UIImage(systemName: "popcorn.fill")
        controller.tabBarItem.title = "Movies"
        return controller
    }
    
    static func buildLocal() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CoreDataCollectionViewAdapter(), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListLocalStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)
        
        controller.tabBarItem.image = UIImage(systemName: "heart")
        controller.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        controller.tabBarItem.title = "Favorites"
        return controller
    }
}
