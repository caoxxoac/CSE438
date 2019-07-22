//
//  ViewController.swift
//  Lab2
//
//  Created by Xiangzhi Cao on 9/13/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // something cool prof. showed in class
    private var currentPet: MyPet!{
        didSet{
            updateDisplay()
        }
    }

    @IBOutlet weak var storageLeft: UILabel!
    @IBOutlet weak var happiness: UILabel!
    @IBOutlet weak var feedLevel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var feedV: UIButton!
    @IBOutlet weak var feedM: UIButton!
    @IBOutlet weak var ply: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buyV: UIButton!
    @IBOutlet weak var buyM: UIButton!
    @IBOutlet weak var pet1: UIButton!
    @IBOutlet weak var pet2: UIButton!
    @IBOutlet weak var pet3: UIButton!
    @IBOutlet weak var pet4: UIButton!
    @IBOutlet weak var pet5: UIButton!
    @IBOutlet weak var theme: UIButton!
    
    
    @IBOutlet weak var happy: DisplayView!
    @IBOutlet weak var feed: DisplayView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        happy.backgroundColor = UIColor.lightGray
        feed.backgroundColor = UIColor.lightGray
        happy.color = UIColor.red
        feed.color = UIColor.red
        
        currentPet = MyPet(happiness: 0, petFeed: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyVege(_ sender: Any) {
        currentPet.buyVege()
        updateDisplay()
    }
    
    @IBAction func buyMeat(_ sender: Any) {
        currentPet.buyMeat()
        updateDisplay()
    }
    
    @IBAction func feedVege(_ sender: Any) {
        currentPet.feedVege()
        updateDisplay()
    }
    
    @IBAction func feedMeat(_ sender: Any) {
        currentPet.feedMeat()
        updateDisplay()
    }
    
    @IBAction func play(_ sender: Any) {
        currentPet.play()
        updateDisplay()
    }
    
    @IBAction func nextDayRefresh(_ sender: Any) {
        currentPet.reset()
        updateDisplay()
    }
    
    @IBAction func getPet1(_ sender: Any) {
        image.image = UIImage(named: "dog")
    }

    @IBAction func getPet2(_ sender: Any) {
        image.image = UIImage(named: "cat")
    }
    
    @IBAction func getPet3(_ sender: Any) {
        image.image = UIImage(named: "fish")
    }
    
    @IBAction func getPet4(_ sender: Any) {
        image.image = UIImage(named: "bunny")
    }
    
    @IBAction func getPet5(_ sender: Any) {
        image.image = UIImage(named: "bird")
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.bgView.backgroundColor = self.getRandomColor()
            let randomColor = self.getRandomColor()
            self.feedV.backgroundColor = randomColor
            self.feedM.backgroundColor = randomColor
            self.ply.backgroundColor = randomColor
            self.nextButton.backgroundColor = self.getRandomColor()
            let randomColor2 = self.getRandomColor()
            self.buyV.backgroundColor = randomColor2
            self.buyM.backgroundColor = randomColor2
            self.happy.backgroundColor = self.getRandomColor()
            self.feed.backgroundColor = self.getRandomColor()
            let randomColor3 = self.getRandomColor()
            self.pet1.backgroundColor = randomColor3
            self.pet2.backgroundColor = randomColor3
            self.pet3.backgroundColor = randomColor3
            self.pet4.backgroundColor = randomColor3
            self.pet5.backgroundColor = randomColor3
            self.theme.backgroundColor = self.getRandomColor()
        })
    }
    

    func getRandomColor() -> UIColor{
        print(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
        return UIColor(red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), alpha: CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
    }
    
    func updateDisplay(){
        storageLeft.text = String(currentPet.storage)
        happiness.text = String(currentPet.happiness)
        feedLevel.text = String(currentPet.petFeed)
        
        let happyValue = Double(currentPet.happiness) / 100
        let feedValue = Double(currentPet.petFeed) / 100
        happy.animateValue(to: CGFloat(happyValue))
        feed.animateValue(to: CGFloat(feedValue))
    }
}

