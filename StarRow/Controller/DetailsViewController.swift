//
//  DetailsViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @objc private func didButtonPressedToAddFavorite(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: (#selector(didButtonPressedToAddFavorite)))
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "In premier", style: .done, target: nil, action: nil)
        // Do any additional setup after loading the view.
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
