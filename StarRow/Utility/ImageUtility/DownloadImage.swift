//
//  DownloadImage.swift
//  StarRow
//
//  Created by El capi lindo on 22/03/24.
//

import Foundation
import UIKit

// MARK: Extesion for download images from internet
extension UIImageView {
    typealias CompletionHandler = (_ image: UIImage?, _ urlImage: String) -> Void

    func downloadImage(_ urlString: String, withAnimation: Bool = true, completion: CompletionHandler? = nil) {
        if withAnimation {
            showAnimationPlaceholder()
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                if let completion = completion {
                    completion(UIImage(systemName: AppConstant.SystemImageNames.personCircle), urlString)
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
                case 400...500:
                    if let completion = completion {
                        completion(UIImage(systemName: AppConstant.SystemImageNames.personCircle), urlString)
                    }
                    break
            default:
                guard let imageData = data else {
                    if let completion = completion {
                        completion(UIImage(systemName: AppConstant.SystemImageNames.personCircle), urlString)
                    }
                    return
                }
                let image = UIImage(data: imageData)
                if let completion = completion {
                    completion(image, urlString)
                }
            }
        }.resume()
    }
        
    private func showAnimationPlaceholder() {
        DispatchQueue.main.async {
            self.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
            
            UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
            }, completion: nil)
        }
    }
    
    func animateAndSetImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 1, options: .transitionCrossDissolve, animations: {
                self.image = image
            }, completion: nil)
        }
    }
    
    private func updatePlaceHolderImage(){
        self.contentMode = .scaleAspectFit
        self.image = UIImage(systemName: AppConstant.SystemImageNames.personCircle)

    }
}
