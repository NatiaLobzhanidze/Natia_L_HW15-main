//
//  DetailsViewController.swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import UIKit


class DetailsViewController: UIViewController {
 
    

    @IBOutlet weak var coverPoster: UIImageView!
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var watchedStatus: UILabel!
    @IBOutlet weak var mainActor: UILabel!
    @IBOutlet weak var overView: UITextView!
    
    var detailsModel: DetailsModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    @IBAction func makeAsFav(_ sender: UIButton) {
        
      
        
        if sender.titleLabel?.text == "Add To Favorite List" {
            sender.setTitle("Remove from Favorite List", for: UIControl.State.normal)
        } else {
            sender.setTitle("Add To Favorite List", for: UIControl.State.normal)
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
