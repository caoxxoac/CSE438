//
//  LineView.swift
//  lab3
//
//  Created by Xiangzhi Cao on 10/1/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import UIKit

class LineView: UIView {

    var theLine: Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lines: [Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    //    func updateCircle(center: CGPoint, radius: CGFloat) {
    //        arcCenter = center
    //        arcRadius = radius
    //        print("updating circle")
    //        setNeedsDisplay()
    //    }
    
    func drawLine(_ line: Line) {
        let path = createQuadPath(points: line.points)
        let newPath1 = UIBezierPath()
        let newPath2 = UIBezierPath()
        if (line.points.count > 1){
            newPath1.addArc(withCenter: line.points[0], radius: line.lineRadius, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
            newPath2.addArc(withCenter: line.points[line.points.count-1], radius: line.lineRadius, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
            newPath1.fill()
            newPath2.fill()
            
            path.lineWidth = line.lineRadius*2
            line.color.setStroke()
            path.stroke()
        }
        else {
            path.addArc(withCenter: line.points[0], radius: line.lineRadius, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
            path.fill()
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        for line in lines {
            line.color.setFill()
            drawLine(line)
        }
        if (theLine != nil) {
            theLine?.color.setFill()
            drawLine(theLine!)
        }
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        return CGPoint(x: (first.x+second.x)/2, y: (first.y+second.y)/2)
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
}
