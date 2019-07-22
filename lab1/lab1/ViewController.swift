//
//  ViewController.swift
//  lab1
//
//  Created by Xiangzhi Cao on 9/5/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var originPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var tax: UITextField!
    
    @IBOutlet weak var savedMoney: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var taxDollar: UILabel!
    @IBOutlet weak var finalPrice: UILabel!
    
    @IBOutlet weak var tSlider: UISlider!
    @IBOutlet weak var disSlider: UISlider!
    
    @IBOutlet weak var chooseStateMenu: UIButton!
    @IBOutlet var stateMenuCollection: [UIButton]!
    
    
    var finalP: Double = 0
    var op: Double = 0
    var dis: Double = 0
    var t: Double = 0
    var savedM: Double = 0
    var taxD: Double = 0
    var stateList = ["Missouri":4.23, "California":7.25, "Arizona":5.6, "None":0.00]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originPrice.delegate = self
        discount.delegate = self
        tax.delegate = self
        
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getOriginalPrice(_ sender: UITextField) {
        //let temp = sender.text!
        op = Double(sender.text!) ?? 0.0
        if (op <= 0){
            finalPrice.text = "$\(String(format: "%.2f", finalP))"
        }
        // make sure nothing shows up if the user only inputs the orginal price
        if (tax.text != ""){
            calculateTax()
        }
        calculation()
    }
   
    @IBAction func getDiscount(_ sender: UITextField) {
        dis = Double(sender.text!) ?? 0.0
        if (dis <= 0){
            dis = 0
        }
        else if (dis >= 100){
            dis = 100
        }
        disSlider.value = Float(Int(dis))
        
        if (tax.text != "") {
            calculateTax()
        }
        calculation()
    }
    
    @IBAction func discountSlider(_ sender: UISlider) {
        dis = Double(sender.value)
        discount.text = String(Int(dis))
        
        if (tax.text != ""){
            calculateTax()
        }
        calculation()
    }
    
    @IBAction func getTax(_ sender: UITextField) {
        t = Double(sender.text!) ?? 0.0
        if (t <= 0){
            t = 0
        }
        else if (t >= 100){
            t = 100
        }
        taxD = (t * op * (1 - dis / 100)).rounded() / 100
        tSlider.value = Float((Double(t)*100).rounded()/100)
        taxLabel.text = String((Double(t)*100).rounded()/100)+"% Tax"
        taxDollar.text = "$\(String(format: "%.2f", taxD))"
        
        chooseStateMenu.titleLabel?.text = "Choose a state"
        
        calculation()
    }
    
    @IBAction func taxSlider(_ sender: UISlider) {
        t = Double(sender.value)
        taxD = (t * op * (1 - dis / 100)).rounded() / 100
        taxLabel.text = String((Double(t)*100).rounded()/100)+"% Tax"
        taxDollar.text = "$\(String(format: "%.2f", taxD))"
        tax.text = String((Double(t)*100).rounded()/100)
        
        chooseStateMenu.titleLabel?.text = "Choose a state"
        calculation()
    }
    
    // for the drop down button part, I borrowed the idea of using UIButton.animate() from a
    // youtube video, and the site is https://www.youtube.com/watch?v=1lgTWEVOAVk
    @IBAction func getDropDownState(_ sender: UIButton) {
        stateMenuCollection.forEach{ (button) in
            UIButton.animate(withDuration: 0.2, animations: {
                if (button.isHidden == true){
                    button.isHidden = false
                }
                else{
                    button.isHidden = true
                }
                // update the layout immediately
                // instead of having the drop down menu moves from the top of the page,
                // it will move from the bottom of the choose button
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func getMenu(_ sender: UIButton) {
        stateMenuCollection.forEach{ (button) in
            UIButton.animate(withDuration: 0.2, animations: {
                if (button.isHidden == true){
                    button.isHidden = false
                }
                else{
                    button.isHidden = true
                }
                self.view.layoutIfNeeded()
            })
        }
        chooseStateMenu.titleLabel?.text = sender.titleLabel?.text
        
        t = Double(stateList[(sender.titleLabel?.text)!]!)
        taxD = (op * t * (1 - dis / 100)).rounded() / 100
        tSlider.value = Float((Double(t)*100).rounded()/100)
        taxLabel.text = String((Double(t)*100).rounded()/100)+"% Tax"
        taxDollar.text = "$\(String(format: "%.2f", taxD))"
        tax.text = String(Double(t))
        calculation()
    }
    
    func calculateTax(){
        taxD = (op * t * (1 - dis / 100)).rounded() / 100
        tSlider.value = Float((Double(t)*100).rounded()/100)
        taxLabel.text = String((Double(t)*100).rounded()/100)+"% Tax"
        taxDollar.text = "$\(String(format: "%.2f", taxD))"
        tax.text = String((Double(t)*100).rounded()/100)
    }
    
    func calculation(){
        finalP = op * (1 - dis / 100) * (1 + t / 100)
        savedM = op * dis / 100
        savedMoney.text = "$\(String(format: "%.2f", savedM))"
        finalPrice.text = "$\(String(format: "%.2f", finalP))"
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == originPrice) {
            let text = (originPrice.text! as NSString).replacingCharacters(in: range, with: string)
            return (text.count) <= 8
        }
        else if (textField == discount) {
            let text = (discount.text! as NSString).replacingCharacters(in: range, with: string)
            return (text.count) <= 3
        }
        else if (textField == tax){
            let text = (tax.text! as NSString).replacingCharacters(in: range, with: string)
            return (text.count) <= 4
        }
        else {
            return true
        }
    }
}
