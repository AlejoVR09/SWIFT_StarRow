//
//  DetailsView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit
import Kingfisher

protocol DetailsViewDelegate {
    
}

class DetailsView: UIView {
    var delegate: DetailsViewDelegate?
    
    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var blurEffect: UIBlurEffect = {
        let blurEffect = UIBlurEffect(style: .dark)
        return blurEffect
    }()
    
    private var visualEffect: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .dark)
        visualEffect.effect = blurEffect
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    
    private var backDrop: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    private var starView: StarMaskView = {
        let starView = StarMaskView()
        return starView
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
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .gray
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
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .gray
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
        addSubview(container)
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 220),
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        container.addSubview(backDrop)
        NSLayoutConstraint.activate([
            backDrop.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            backDrop.topAnchor.constraint(equalTo: container.topAnchor),
            backDrop.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            backDrop.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
        
        backDrop.addSubview(visualEffect)
        NSLayoutConstraint.activate([
            visualEffect.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            visualEffect.topAnchor.constraint(equalTo: container.topAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
        
        container.addSubview(poster)
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.3),
            poster.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            poster.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            poster.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10)
        ])
        
        container.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10)
        ])
        
        container.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 50),
            releaseDateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10)
        ])
        
        
        addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
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
        var array = data.genrers
        self.backDrop.kf.setImage(with: URL(string: url + data.backDrop))
        self.poster.kf.setImage(with: URL(string: url + data.poster))
        self.titleLabel.text = data.name
        self.releaseDateLabel.text = "Release Date: \n" + data.releaseDate
        self.genreLabel.text = "Generos"
        var genersConcact = "" + (array.remove(at: 0).name ?? "")
        for i in array { genersConcact += " º " + (i.name ?? "") }
        self.genrers.text = genersConcact
        self.descriptionLabel.text = "Description"
        self.descriptionData.text = data.description
    }
}
