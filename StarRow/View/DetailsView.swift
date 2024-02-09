//
//  DetailsView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

protocol DetailsViewDelegate {
    
}

class DetailsView: UIView {
    var delegate: DetailsViewDelegate?
    @IBOutlet private weak var backDrop: UIImageView!
    @IBOutlet private weak var poster: UIImageView!
    
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var genrers: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionData: UILabel!
    
    func setUpView(data: DetailsMovieDTO){
        let url = "https://image.tmdb.org/t/p/w500"
        self.backDrop.kf.setImage(with: URL(string: url+data.backDrop))
        self.poster.kf.setImage(with: URL(string: url+data.poster))
        self.genreLabel.text = "Generos"
        var genersConcact = ""
        for i in data.genrers {
            genersConcact += (i.name ?? "")+"º"
        }
        self.genrers.text = genersConcact
        self.descriptionLabel.text = "Description"
        self.descriptionData.text = data.description
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
