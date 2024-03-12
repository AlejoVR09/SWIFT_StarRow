//
//  DetailsView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class DetailsView: UIView {
    init() {
        bottomConstraint = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: genrers,
            attribute: .bottom,
            multiplier: 1,
            constant: 40)
        bottomConstraint.priority = UILayoutPriority(900)
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = UIColor(named: "Main")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Main")
        return view
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = UIColor(named: "MainInverse")
        activity.tintColor = UIColor(named: "MainInverse")
        activity.startAnimating()
        return activity
    }()
    
    private var referenceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Main")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var visualEffect: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView()
        visualEffect.effect = UIBlurEffect(style: .dark)
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
        label.numberOfLines = 0
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var starView: StarMaskView = StarMaskView(size: 180)
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "MainInverse")
        label.numberOfLines = 0
        return label
    }()
    
    private var genrers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(cgColor: .init(red: 0.590, green: 0.590, blue: 0.590, alpha: 1))
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "MainInverse")
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionData: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(cgColor: .init(red: 0.590, green: 0.590, blue: 0.590, alpha: 1))
        label.numberOfLines = 0
        return label
    }()
    
    private var bottomConstraint: NSLayoutConstraint
}

extension DetailsView{
    func addLoadingView(){
        self.scrollView.isHidden = true
        self.loadingView.isHidden = false
    }
    
    func removeLoadingView(){
        self.scrollView.isHidden = false
        self.loadingView.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    private func downloadImage(data: String, element: UIImageView){
        let url = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: url + data) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    element.image = UIImage(named: "star")
                }
                return
            }
            guard let imageData = data else {
                DispatchQueue.main.async {
                    element.image = UIImage(named: "star")
                }
                return
            }
            DispatchQueue.main.async {
                element.image = UIImage(data: imageData as Data)
            }
        }.resume()
    }
    
    func setUpView(data: DetailsMovieEntity){
        self.downloadImage(data: data.poster, element: self.poster)
        self.downloadImage(data: data.backDrop, element: self.backDrop)
        var array = data.genrers
        self.titleLabel.text = data.name
        self.releaseDateLabel.text = "Release Date: \n" + MoviesEntity.formatDate(data.releaseDate)
        self.starView.setProgress(num: Float(data.voteAverage))
        self.genreLabel.text = "Generos"
        var genersConcact = "" + (array.remove(at: 0).name ?? "")
        for i in array { genersConcact += " º " + (i.name ?? "") }
        self.genrers.text = genersConcact
        self.descriptionLabel.text = "Description"
        self.descriptionData.text = data.description
    }
}

extension DetailsView {
    private func setConstraints(){
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        loadingView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        scrollView.addSubview(referenceView)
        NSLayoutConstraint.activate([
            referenceView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            referenceView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            referenceView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            referenceView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            referenceView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
        
        referenceView.addSubview(container)
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 220),
            container.topAnchor.constraint(equalTo: referenceView.topAnchor),
            container.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor),
            container.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor)
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
        
        container.addSubview(starView)
        NSLayoutConstraint.activate([
            starView.heightAnchor.constraint(equalToConstant: 20),
            starView.widthAnchor.constraint(equalToConstant: 180),
            starView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            starView.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10)
        ])
        
        
        referenceView.addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor, constant: 20)
        ])
        
        referenceView.addSubview(genrers)
        NSLayoutConstraint.activate([
            genrers.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            genrers.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor, constant: 20),
            genrers.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor, constant: 20)
        ])
        
        referenceView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            bottomConstraint,
            descriptionLabel.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor, constant: 20)
        ])
        
        referenceView.addSubview(descriptionData)
        NSLayoutConstraint.activate([
            descriptionData.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionData.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor, constant: -20),
            descriptionData.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor, constant: 20),
            descriptionData.bottomAnchor.constraint(equalTo: referenceView.bottomAnchor, constant: 10)
        ])
    }
}
