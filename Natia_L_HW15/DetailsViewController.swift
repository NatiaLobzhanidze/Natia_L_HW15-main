//
//  DetailsViewController.swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import UIKit

protocol MakeFavList {
    func passFavoriteMovieTitle(from arr: [String])
}
class DetailsViewController: UIViewController {
 
    var favoriteMoveis = Set<String>()

    @IBOutlet weak var coverPoster: UIImageView!
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var watchedStatus: UILabel!
    @IBOutlet weak var mainActor: UILabel!
    @IBOutlet weak var overView: UITextView!
    
    var detailsModel: DetailsModel?
    
    var delegate: MakeFavList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func makeAsFav(_ sender: UIButton) {
        
        guard let title = self.movieTitle.text else { return }
       // favoriteMoveis.append()

       
        if sender.titleLabel?.text == "Add To Favorite List" {
            sender.setTitle("Remove from Favorite List", for: UIControl.State.normal)
            favoriteMoveis.insert(title)
            delegate?.passFavoriteMovieTitle(from: Array(favoriteMoveis))
        } else {
            sender.setTitle("Add To Favorite List", for: UIControl.State.normal)
            favoriteMoveis.remove(title)
            delegate?.passFavoriteMovieTitle(from: Array(favoriteMoveis))
        }
    }
    
    func setUpView(){
        guard let movieDetails = detailsModel else { return }
        coverPoster.image = movieDetails.coverImage
        mainPoster.image = movieDetails.image
        movieTitle.text = movieDetails.title
        imdbRating.text = String(movieDetails.imdb)
        releaseDate.text = "\(movieDetails.releaseDate)"
        watchedStatus.text = movieDetails.seen ? "Watched" : "Going to Watch"
        mainActor.text = movieDetails.mainActor
        overView.text = movieDetails.description
    }
}
