//
//  ViewController.swift
//  Natia_L_HW15
//
//  Created by Natia's Mac on 12.07.22.
//

import UIKit
protocol GetDetailsDelegate {
    func getDetails(of movie: Movie)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailsDelegate: GetDetailsDelegate!
    var mybool = false
    var movieList = [Movie]()
    var filteredArray = [Movie]()
    var watchedArray = [Movie]()
    var unwatchedArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeMovieList()
        tableView.delegate = self
        tableView.dataSource = self
        
      
       
    }
    
    
    @IBAction func makeFavList(_ sender: UIButton) {
        watchedArray.removeAll()
        unwatchedArray.removeAll()
        watchedArray = filteredArray.filter({$0.seen == true })
        unwatchedArray = filteredArray.filter({$0.seen == false })
        mybool = true
        tableView.reloadData()
        
    }
    
    @IBAction func allSeenMoviesBtn(_ sender: Any) {
        watchedArray = movieList.filter({$0.seen == true })
        unwatchedArray = movieList.filter({$0.seen == false })
        tableView.reloadData()
        
    }
    
    func makeMovieList() {
        for i in 0..<titlesAndActorsDictionary.count {
            let title = titlesAndActorsDictionary.keys.map{$0}[i]
            let actor = titlesAndActorsDictionary.values.map{$0}[i]
            movieList.append(Movie(image: UIImage(named: title), title: title, releaseDate: "\(Int.random(in: 2005...2022))", imdb: Double( Double.random(in: 0...5).format(f: oneFormat)) ?? 0.0, mainActor: actor, seen: Bool.random(), isFavourite: Bool.random()))
        }
      
         

   
        watchedArray = movieList.filter({$0.seen == true })
        unwatchedArray = movieList.filter({$0.seen == false })
        
    }
}


extension ViewController: MakeFavList {
    
    func passFavoriteMovieTitle(from arr: [String]) {
        for elem in arr  {
            filteredArray = movieList.filter{$0.title == elem}
        }
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, MovieListDelegate {
    
    func changeSection(for cell: MovieListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if indexPath.section  == 0 {
            var chooseCell = watchedArray[indexPath.row]
            chooseCell.seen = !chooseCell.seen
            watchedArray.remove(at: indexPath.row)
            unwatchedArray.append(chooseCell)
            tableView.reloadData()
        } else {
            var chooseCell = unwatchedArray[indexPath.row]
            chooseCell.seen = !chooseCell.seen
            unwatchedArray.remove(at: indexPath.row)
            watchedArray.append(chooseCell)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return watchedArray.count
        } else {
            return unwatchedArray.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell
        if let cell = cell {
            if indexPath.section == 0 {
                
                
                cell.configure(with: watchedArray[indexPath.row])
                cell.movieDelegate = self
                return cell
            } else {
                cell.configure(with: unwatchedArray[indexPath.row])
                cell.movieDelegate = self
                return cell
            }
        }else { return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Seen"
        } else {
            return  "Going to See "
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Details", bundle: nil)
        let vc  = sb.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        guard let  vc = vc else { return }
        if indexPath.section == 0 {
            let elem = watchedArray[indexPath.row]
            vc.detailsModel = DetailsModel(image: elem.image, coverImage: elem.image, title: elem.title, releaseDate: elem.releaseDate, imdb: elem.imdb, mainActor: elem.mainActor, seen: elem.seen, isFavourite: elem.isFavourite, description: elem.description)
        } else {
            let elem = unwatchedArray[indexPath.row]
            vc.detailsModel = DetailsModel(image: elem.image, coverImage: elem.image, title: elem.title, releaseDate: elem.releaseDate, imdb: elem.imdb, mainActor: elem.mainActor, seen: elem.seen, isFavourite: elem.isFavourite, description: elem.description)
        }
       
        vc.delegate = self
        navigationController?.pushViewController( vc, animated: true)
        
    }
}


