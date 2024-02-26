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
    
    private var visualEffect: UIVisualEffectView = {
       let visualEffect = UIVisualEffectView()
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    
    private var poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var genrers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var descriptionData: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private var bottomConstraint: NSLayoutConstraint
    
    init() {
        bottomConstraint = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: genrers,
            attribute: .bottom,
            multiplier: 1,
            constant: 20)
        bottomConstraint.priority = UILayoutPriority(900)
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView{
    private func setConstraints(){
        
        addSubview(visualEffect)
        NSLayoutConstraint.activate([
            visualEffect.heightAnchor.constraint(equalToConstant: 250),
            visualEffect.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        visualEffect.contentView.addSubview(poster)
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalTo: visualEffect.contentView.widthAnchor, multiplier: 0.3),
            poster.topAnchor.constraint(equalTo: visualEffect.contentView.topAnchor, constant: 10),
            poster.bottomAnchor.constraint(equalTo: visualEffect.contentView.bottomAnchor, constant: -10),
            poster.leadingAnchor.constraint(equalTo: visualEffect.contentView.leadingAnchor, constant: 10)
        ])
        
        addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: visualEffect.bottomAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        addSubview(genrers)
        NSLayoutConstraint.activate([
            genrers.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            genrers.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20),
            genrers.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            bottomConstraint,
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        addSubview(descriptionData)
        NSLayoutConstraint.activate([
            descriptionData.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionData.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionData.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func setUpView(data: DetailsMovieEntity){
        let url = "https://image.tmdb.org/t/p/w500"
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
}
