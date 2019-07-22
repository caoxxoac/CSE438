//
//  BlockListViewController.swift
//  lab4
//
//  Created by Xiangzhi Cao on 10/20/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class BlockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var blockMovieTable: UITableView!
    
    var blockMovieTitles:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockMovieTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = blockMovieTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            blockMovieTitles.remove(at: indexPath.row)
            UserDefaults.standard.set(blockMovieTitles, forKey: "blockList")
            self.blockMovieTable.reloadData()
        }
    }
    
    func setupTableView(){
        blockMovieTable.dataSource = self
        blockMovieTable.delegate = self
        blockMovieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        blockMovieTitles = []
        
        let movies = UserDefaults.standard.array(forKey: "blockList")
        if (movies != nil){
            for movie in movies!{
                blockMovieTitles.append(movie as! String)
            }
            self.blockMovieTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        let movies = UserDefaults.standard.array(forKey: "blockList")
        if (movies != nil){
            for movie in movies!{
                blockMovieTitles.append(movie as! String)
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
