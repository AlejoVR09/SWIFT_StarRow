//
//  TabBarController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "In premier"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem =
        UIBarButtonItem(title: NSLocalizedString("logOut", comment: ""), style: .done, target: nil, action: (#selector(didButtonPressedLogOut)))
        
        guard
            let items = self.tabBar.items
        else{
            return
        }

        items[0].title = "Movies"
        items[0].image = UIImage(systemName: "movieclapper.fill")
        items[1].title = "Favorites"
        items[1].image = UIImage(systemName: "star.fill")
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func didButtonPressedLogOut(){
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
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
