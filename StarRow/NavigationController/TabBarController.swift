import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "appTittle".localized(withComment: "appTittleComment".localized())
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(didButtonPressedLogOut)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.setViewControllers([TabBarController.buildOnline(), TabBarController.buildLocal()], animated: true)
        self.tabBar.backgroundColor = UIColor(named: AppConstant.Color.mainColor)
    }
    
    @objc func didButtonPressedLogOut(){
        self.navigationController?.present(ProfileViewController(profileView: ProfileView(), delegate: self), animated: true)
    }
}

extension TabBarController {
    static func buildOnline() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: OnlineAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListOnlineStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)

        controller.tabBarItem.image = UIImage(systemName: "square.split.2x2")
        controller.tabBarItem.selectedImage = UIImage(systemName: "square.split.2x2.fill")
        controller.tabBarItem.title = "MoviesTab".localized(withComment: "MoviesTabComment".localized())
        return controller
    }
    
    static func buildLocal() -> MoviesViewController {
        let moviesView = MoviesView(adapter: CollectionViewAdapter(strategy: LocalAdapterStrategy()), searchBarAdapter: MovieSearchAdapter())
        let strategy = MoviesListLocalStrategy(moviesView: moviesView)
        let controller = MoviesViewController(moviesView: moviesView, strategy: strategy)
        
        controller.tabBarItem.image = UIImage(systemName: "star")
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        controller.tabBarItem.title = "FavoritesTab".localized(withComment: "FavoritesTabComment".localized())
        return controller
    }
}

extension TabBarController: ProfileViewControllerDelegate {
    func closeViewController(_ profileViewController: ProfileViewController) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
