//
//  FavoriteViewController.swift
//  lab4
//
//  Created by Xiangzhi Cao on 10/19/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var favoriteMovieTable: UITableView!
    
    var movieTitles: [String] = []
    var bgColor: [UIColor]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = movieTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            movieTitles.remove(at: indexPath.row)
            UserDefaults.standard.set(movieTitles, forKey: "favoriteList")
            self.favoriteMovieTable.reloadData()
        }
    }
    
    func setupTableView(){
        favoriteMovieTable.dataSource = self
        favoriteMovieTable.delegate = self
        favoriteMovieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        movieTitles = []
        
        let movies = UserDefaults.standard.array(forKey: "favoriteList")
        if (movies != nil){
            for movie in movies!{
                movieTitles.append(movie as! String)
            }
            self.favoriteMovieTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupTableView()
        let movies = UserDefaults.standard.array(forKey: "favoriteList")
        if (movies != nil){
            for movie in movies!{
                movieTitles.append(movie as! String)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
