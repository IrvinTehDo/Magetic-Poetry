// By Irvin Do and Kyle Lekkas
//  ViewController.swift
//  Magnetic Poetry
//
//  Created by Irvin Do on 1/30/18.
//  Copyright © 2018 Irvin Do and Kyle Lekkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placeWords()
    }
    
    func placeWords() {
        //same color as start screen
        view.backgroundColor = UIColor.init(red: 0.168, green: 0.541, blue: 0.560, alpha: 1.0)
        
        var xPlacement = 80
        var yPlacement = 50
        let margin = 35
        
        for word in words {
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = word
            label.font = UIFont(name: "HelveticaNeue", size: 40.0)
            label.sizeToFit()
            
            if (label.frame.width + CGFloat(margin) + CGFloat(xPlacement) > view.frame.size.width) {
                xPlacement = 80
                yPlacement += 50
            }
            
            let xPos = margin + Int(xPlacement)
            xPlacement = xPos + Int(label.frame.width)
            
            let yPos = yPlacement
            label.center = CGPoint(x:xPos, y:yPos)
            
            //temp constraint to fix iphone placement
            if (yPlacement <= Int(view.frame.height/3)) {
                view.addSubview(label)
            }

            
            label.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            label.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }


}

