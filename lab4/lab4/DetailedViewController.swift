//
//  DetailedViewController.swift
//  lab4
//
//  Created by Xiangzhi Cao on 10/17/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    var poster: UIImage!
    var movieTitle: String!
    var movieOverview: String!
    var movieReleaseDate: String!
    var movieScore: Double!
    // var movieRating: String!
    
    var favoriteMovieTitle: [String] = []
    var blockMovieTitle: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let posterBG = CGRect(x: 0, y: 80, width: view.frame.width, height: poster.size.height)
        let posterBGView = UIView(frame: posterBG)
        posterBGView.backgroundColor = UIColor.gray
        
        let theImageFrame = CGRect(x: view.frame.midX-poster.size.width/2, y: 80, width: poster.size.width, height: poster.size.height)
        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = poster
        
        let titleFrame = CGRect(x: view.frame.midX-200, y: poster.size.height+100, width: 400, height: 30)
        let titleView = UILabel(frame: titleFrame)
        titleView.text = "Movie Title: "+movieTitle
        titleView.textAlignment = NSTextAlignment.center
        
        // let overViewFrame = CGRect(x: 0, y: poster.size.height+80, width: view.frame.width, height: 30)
        // let overview = UILabel(frame: overViewFrame)
        // overview.text = movieOverview
        
        let releaseDateFrame = CGRect(x: view.frame.midX-150, y: poster.size.height+150, width: 300, height: 30)
        let releaseDateView = UILabel(frame: releaseDateFrame)
        releaseDateView.text = "Released: "+movieReleaseDate
        releaseDateView.textAlignment = NSTextAlignment.center
        
        let movieScoreFrame = CGRect(x: view.frame.midX-75, y: poster.size.height+200, width: 150, height: 30)
        let movieScoreView = UILabel(frame: movieScoreFrame)
        movieScoreView.text = "Score: "+String(Int(movieScore*10))+" / 100"
        movieScoreView.textAlignment = NSTextAlignment.center
        
        let favoriteButtonFrame = CGRect(x: view.frame.midX-75, y: poster.size.height+250, width: 150, height: 30)
        let favoriteButtonView = UIButton(frame: favoriteButtonFrame)
        favoriteButtonView.setTitle("Add to favorite", for: .normal)
        favoriteButtonView.setTitleColor(UIColor.blue, for: .normal)
        favoriteButtonView.layer.borderColor = UIColor.blue.cgColor
        favoriteButtonView.layer.borderWidth = 1.0
        favoriteButtonView.addTarget(self, action: #selector(self.addFavoriteMovie(_:)), for: .touchUpInside)
        
        let blockButtonFrame = CGRect(x: view.frame.midX-75, y: poster.size.height+300, width: 150, height: 30)
        let blockButtonView = UIButton(frame: blockButtonFrame)
        blockButtonView.setTitle("Add to block list", for: .normal)
        blockButtonView.setTitleColor(UIColor.gray, for: .normal)
        blockButtonView.layer.borderColor = UIColor.gray.cgColor
        blockButtonView.layer.borderWidth = 1.0
        blockButtonView.addTarget(self, action: #selector(self.addBlockMovie(_:)), for: .touchUpInside)
        
        view.addSubview(posterBGView)
        view.addSubview(imageView)
        view.addSubview(titleView)
        //view.addSubview(overview)
        view.addSubview(releaseDateView)
        view.addSubview(movieScoreView)
        view.addSubview(favoriteButtonView)
        view.addSubview(blockButtonView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addFavoriteMovie(_ sender: UIButton) {
        let alertTitle = "Add to Favorites"
        var alertMessage = "You have added the movie '"+movieTitle+"' to my favorite movies successfully"
        
        if (UserDefaults.standard.array(forKey: "favoriteList") != nil){
            favoriteMovieTitle = UserDefaults.standard.array(forKey: "favoriteList") as! [String]
        }
        if (!favoriteMovieTitle.contains(movieTitle)){
            favoriteMovieTitle.append(movieTitle)
            UserDefaults.standard.set(favoriteMovieTitle, forKey: "favoriteList")
        }
        else {
            alertMessage = "The movie is already in your favorite list"
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addBlockMovie(_ sender: UIButton){
        let alertTitle = "Add to Blocks"
        var alertMessage = "You have added the movie '"+movieTitle+"' to my block movie list successfully"
        
        if (UserDefaults.standard.array(forKey: "blockList") != nil){
            blockMovieTitle = UserDefaults.standard.array(forKey: "blockList") as! [String]
        }
        if (!blockMovieTitle.contains(movieTitle)){
            blockMovieTitle.append(movieTitle)
            UserDefaults.standard.set(blockMovieTitle, forKey: "blockList")
        }
        else {
            alertMessage = "The movie is already in you block list"
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
