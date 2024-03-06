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
        self.tabBar.backgroundColor = UIColor(named: "Main")
    }
    
    @objc func didButtonPressedLogOut(){
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension TabBarController {
    static func buildOnline() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: OnlineAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListOnlineStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)

        controller.tabBarItem.image = UIImage(systemName: "square.split.2x2")
        controller.tabBarItem.selectedImage = UIImage(systemName: "square.split.2x2.fill")
        controller.tabBarItem.title = "Movies"
        return controller
    }
    
    static func buildLocal() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: LocalAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListLocalStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)
        
        controller.tabBarItem.image = UIImage(systemName: "star")
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        controller.tabBarItem.title = "Favorites"
        return controller
    }
}
