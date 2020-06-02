//
//  MovieDetailViewController.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 29/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

protocol MovieDetailInteractorProtocol {
    func viewDidLoad()
    func favoriteButtonClicked()
}

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {

    private let interactor: MovieDetailInteractorProtocol
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    init(withInteractor interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detalhe do Filme"
        interactor.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupLayout() {
        favoriteButton.setBackgroundImage(UIImage(named: "favorite_movie_icon"), for: .selected)
        favoriteButton.setBackgroundImage(UIImage(named: "not_favorite_movie_icon"), for: .normal)
    }
    
    @IBAction func favoriteMovieButtonClicked(_ sender: Any) {
        interactor.favoriteButtonClicked()
    }
    
    //MARK: MovieDetailViewProtocol
    func updateMovieDetails(_ movie: MovieDetailViewModel, isFavorite: Bool) {
        movieTitleLabel.text = movie.title
        backImageView.loadImageFrom(path: movie.backdropPath ?? "")
        yearLabel.text = movie.year
        posterImageView.loadImageFrom(path: movie.posterPath)
        overviewLabel.text = movie.movieOverview
        favoriteButton.isSelected = isFavorite
        
        let provider = UserDefaultProvider.shared
        let movie: DefaultMovieViewModel? = provider.getValue(forKey: movie.title)
        print(movie?.name)
    }
}
