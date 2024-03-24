import UIKit

// MARK: Class Declaration
class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AppConstant.Translations.appTittle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: AppConstant.SystemImageNames.personCircle),
            style: .plain,
            target: self,
            action: #selector(didButtonPressedLogOut)
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.setViewControllers([MoviesViewController.buildOnline(), MoviesViewController.buildLocal()], animated: true)
        self.tabBar.backgroundColor = UIColor(named: AppConstant.Color.mainColor)
    }
}

// MARK: Selectors
extension TabBarController {
    @objc func didButtonPressedLogOut(){
        self.navigationController?.present(ProfileViewController.buildProfileViewController(delegate: self), animated: true)
    }
}

// MARK: Delegates
extension TabBarController: ProfileViewControllerDelegate {
    func closeViewController(_ profileViewController: ProfileViewController) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: Builders
extension TabBarController {
    class func buildTabBarController() -> TabBarController {
        let controller = TabBarController()
        return controller
    }
}
