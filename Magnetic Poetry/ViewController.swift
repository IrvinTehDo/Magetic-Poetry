//
//  ViewController.swift
//  Magnetic Poetry
//
//  Created by Irvin Do on 1/30/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placeWords()
    }
    
    func placeWords(){
        view.backgroundColor = UIColor.orange
        
        var xPlacement = 80
        var yPlacement = 50
        let margin = 35
        
        for word in words{
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = word
            l.font = UIFont(name: "HelveticaNeue", size: 40.0)
            l.sizeToFit()
            
            if l.frame.width + CGFloat(margin) + CGFloat(xPlacement) > view.frame.size.width{
                xPlacement = 80
                yPlacement += 50
            }
            
            let x = margin + Int(xPlacement)
            xPlacement = x + Int(l.frame.width)
            
            let y = yPlacement
            l.center = CGPoint(x:x, y:y)
            view.addSubview(l)
            
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }


}

