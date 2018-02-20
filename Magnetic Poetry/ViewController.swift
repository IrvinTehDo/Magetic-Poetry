// By Irvin Do and Kyle Lekkas
//  ViewController.swift
//  Magnetic Poetry
//
//  Created by Irvin Do on 1/30/18.
//  Copyright © 2018 Irvin Do and Kyle Lekkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //var words: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //same color as start screen
        view.backgroundColor = UIColor.init(red: 0.168, green: 0.541, blue: 0.560, alpha: 1.0)
    }
    
    //Removes every label from view
    func removeWords(){
        for v in view.subviews{
            if (v is UILabel){
                v.removeFromSuperview()
            }
        }
    }
    
    //Places and Creates Labels based on an array of words
    func placeWords(words:[String]) {
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
            
            //temp constraint to fix iphone placement
            if (yPlacement <= Int(view.frame.height/3)) {
                view.addSubview(l)
            }
            
            
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWordSegue"{
            let wordSetVC = segue.destination.childViewControllers[0] as! WordSetVC
            //wordsVC.words = ["a", "b", "c"]
            wordSetVC.title = "Choose a Word List"
        }
    }

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if (segue.identifier == "DoneTapped"){
            let wordSetVC = segue.source as! WordSetVC
            let wordSet = wordSetVC.selectedWordSet
            removeWords()
            placeWords(words: wordSet!)
        }
    }
    
}

