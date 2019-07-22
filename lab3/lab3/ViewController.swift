//
//  ViewController.swift
//  lab3
//
//  Created by Xiangzhi Cao on 9/28/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentLine: Line = Line()
    var lineCanvas: LineView!
    var lineRadius: CGFloat!
    
    @IBOutlet weak var radiusSlider: UISlider!
    
    @IBOutlet weak var rSlider: UISlider!
    
    @IBOutlet weak var gSlider: UISlider!
    
     @IBOutlet weak var bSlider: UISlider!
    
    @IBAction func clearScreen(_ sender: Any) {
        lineCanvas.theLine = nil
        lineCanvas.lines = []
        currentLine = Line()
        rSlider.value = 0
        gSlider.value = 0
        bSlider.value = 0
    }
   
    
    @IBAction func undoScreen(_ sender: Any) {
        if (lineCanvas.lines.count > 0){
            lineCanvas.theLine = nil
            lineCanvas.lines.remove(at: lineCanvas.lines.count-1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineRadius = currentLine.lineRadius
        lineCanvas = LineView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-135))
        view.addSubview(lineCanvas)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        currentLine.color = sender.backgroundColor!
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        currentLine.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        rSlider.value = Float(red)
        gSlider.value = Float(green)
        bSlider.value = Float(blue)
    }
    
    
    @IBAction func sliderChangeColor(_ sender: Any) {
        currentLine.color = UIColor(red: CGFloat(rSlider.value), green: CGFloat(gSlider.value), blue: CGFloat(bSlider.value), alpha: 1)
    }
    
    @IBAction func takeScreenShot(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        if (radiusSlider.value < 0.01){
            currentLine.lineRadius = 0.2
        }
        else {
            currentLine.lineRadius = lineRadius * CGFloat(radiusSlider.value)
        }
        print("You started at \(touchPoint)")
        currentLine.points.append(touchPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        print("You moved to \(touchPoint)")
        currentLine.points.append(touchPoint)
        lineCanvas.theLine = currentLine
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        print("You ended at \(touchPoint)")
        if (currentLine.points.count > 0) {
            let newLine = currentLine
            lineCanvas.lines.append(newLine)
            
            // reset
            currentLine.points = []
            lineCanvas.theLine = nil
        }
    }

}

