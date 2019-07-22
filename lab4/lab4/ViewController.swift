//
//  ViewController.swift
//  lab4
//
//  Created by Xiangzhi Cao on 10/16/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var theMovie: [Movie] = []
    var moviePoster: [UIImage] = []
    var movieTitle: [String] = []
    var apiResults: APIResults!
    var themeColor: UIColor = UIColor.white
    var currentMovieName: String!
    
    var blockMovieList:[String] = []
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    func setUpCollectionView(){
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        // let nib = UINib(nibName: "theMovieCell", bundle: nil)
        // movieCollectionView.register(nib, forCellWithReuseIdentifier: "theMovifeCell")
        movieCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "theMovieCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // time to push on the detailed view
        let detailedVC = DetailedViewController()
        detailedVC.poster = moviePoster[indexPath.row]
        detailedVC.movieTitle = theMovie[indexPath.row].title
        detailedVC.movieReleaseDate = theMovie[indexPath.row].release_date
        detailedVC.movieOverview = theMovie[indexPath.row].overview
        detailedVC.movieScore = theMovie[indexPath.row].vote_average
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func fetchDataForCollectionView(){
        let apiKey = "93d184905a6b1f6fec4bcc2f5ad67913"
        if (currentMovieName != ""){
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key="+apiKey+"&query="+currentMovieName!)
            let data = try? Data(contentsOf: url!)
            apiResults = try! JSONDecoder().decode(APIResults.self, from: data!)
            let movieInfo = apiResults.results
            let movieNum = movieInfo.count
            if (movieNum != 0){
                for movie in movieInfo{
                    if (!blockMovieList.contains(movie.title)){
                        let movieTitle = movie.title
                        let movieID = movie.id
                        let moviePosterPath = movie.poster_path
                        let movieReleaseDate = movie.release_date
                        let movieVoteAverage = movie.vote_average
                        let movieOverview = movie.overview
                        let movieVoteCount = movie.vote_count
                        theMovie.append(Movie(id: movieID, poster_path: moviePosterPath, title: movieTitle, release_date: movieReleaseDate, vote_average: movieVoteAverage, overview: movieOverview, vote_count: movieVoteCount))
                    }
                }
            }
        }
    }
    
    func catchImages(){
        for movie in theMovie{
            if (movie.poster_path != nil){
                let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185"+movie.poster_path!)
                let data = try? Data(contentsOf: posterUrl!)
                if (data != nil){
                    let image = UIImage(data: data!)
                    moviePoster.append(image!)
                }
                else{
                    moviePoster.append(UIImage(named: "noMovieAvailable.jpeg")!)
                }
            }
            else{
                moviePoster.append(UIImage(named: "noMovieAvailable.jpeg")!)
            }
            movieTitle.append(movie.title)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = UICollectionView(frame: , collectionViewLayout: UICollectionViewLayout)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "theMovieCell", for: indexPath)
        
        let posterFrame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        let posterView = UIImageView(frame: posterFrame)
        posterView.image = moviePoster[indexPath.row]
        
        let titleFrame = CGRect(x: 0, y: cell.frame.height-25, width: cell.frame.width, height: 25)
        let titleView = UILabel(frame: titleFrame)
        titleView.text = movieTitle[indexPath.row]
        titleView.font = UIFont(name: "Times New Roman", size: 12)
        titleView.textColor = UIColor.white
        titleView.textAlignment = NSTextAlignment.center
        titleView.backgroundColor = UIColor.gray

        cell.addSubview(posterView)
        cell.addSubview(titleView)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        theMovie = []
        moviePoster = []
        movieTitle = []
        self.movieCollectionView.reloadData()
        
        self.activityIndicatorView.startAnimating()
        
        currentMovieName = searchBar.text
        currentMovieName = currentMovieName?.replacingOccurrences(of: " ", with: "%20")
        
        DispatchQueue.global(qos: .userInitiated).async {
            if (UserDefaults.standard.array(forKey: "blockList") as? [String] != nil){
                self.blockMovieList = UserDefaults.standard.array(forKey: "blockList") as! [String]
            }
            self.fetchDataForCollectionView()
            self.catchImages()
            
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpCollectionView()
        movieSearch.delegate = self
        activityIndicatorView.color = UIColor.blue
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(activityIndicatorView)
        
        // the keyboard will go away after user click somewhere on the screen
        // self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // creative parts
    @IBAction func share(_ sender: Any) {
        // I found a way to send email on 'http://www.thomashanning.com/mfmailcomposeviewcontroller/'
        let alertTitle = "Email Sending Status"
        var alertMessage = "You have to set up the email account on the device first"
        if (MFMailComposeViewController.canSendMail()){
            let screenShot = takeScreenShot(sender)
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            
            mailComposeViewController.setToRecipients(["xcao22@wustl.edu"])
            mailComposeViewController.setSubject("Search Content: "+movieSearch.text!)
            mailComposeViewController.setMessageBody("This is my screenshot, do you like it?", isHTML: false)
            mailComposeViewController.addAttachmentData(UIImagePNGRepresentation(screenShot)!, mimeType: "image/png", fileName: "screenshot.png")
            
            self.present(mailComposeViewController, animated: true, completion: nil)
            
            alertMessage = "Congratulations! You have sent the email of your screen shot successuflly!"
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func takeScreenShot(_ sender: Any) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        return image!
    }
    
    @IBAction func changeBGColor(_ sender: Any) {
        themeColor = self.getRandomColor()
        self.view.backgroundColor = themeColor
        self.movieCollectionView.backgroundColor = themeColor
    }
    
    func getRandomColor() -> UIColor{
        return UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
    }
}

