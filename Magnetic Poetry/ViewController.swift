// By Irvin Do and Kyle Lekkas
//  ViewController.swift
//  Magnetic Poetry
//
//  Created by Irvin Do on 1/30/18.
//  Copyright © 2018 Irvin Do and Kyle Lekkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var words:[(word: String, type: String, isVisible: Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Add words and their types to words array
        //Types: Article, conjunction, adjective, noun, pronoun, verb
        words += [(word: "a", type: "article", isVisible: false)]
        words += [(word: "a", type: "article", isVisible: false)]
        words += [(word: "&", type: "conjunction", isVisible: false)]
        words += [(word: "&", type: "conjunction", isVisible: false)]
        words += [(word: "about", type: "adjective", isVisible: false)]
        words += [(word: "above", type: "adjective", isVisible: false)]
        words += [(word: "ache", type: "noun", isVisible: false)]
        words += [(word: "ad", type: "noun", isVisible: false)]
        words += [(word: "am", type: "article", isVisible: false)]
        words += [(word: "am", type: "article", isVisible: false)]
        words += [(word: "and", type: "conjunction", isVisible: false)]
        words += [(word: "and", type: "conjunction", isVisible: false)]
        words += [(word: "because", type: "conjunction", isVisible: false)]
        words += [(word: "but", type: "conjunction", isVisible: false)]
        words += [(word: "for", type: "conjunction", isVisible: false)]
        words += [(word: "if", type: "conjunction", isVisible: false)]
        words += [(word: "or", type: "conjunction", isVisible: false)]
        words += [(word: "he", type: "pronoun", isVisible: false)]
        words += [(word: "she", type: "pronoun", isVisible: false)]
        words += [(word: "they", type: "pronoun", isVisible: false)]
        words += [(word: "I", type: "pronoun", isVisible: false)]
        words += [(word: "you", type: "pronoun", isVisible: false)]
        words += [(word: "me", type: "pronoun", isVisible: false)]
        words += [(word: "them", type: "pronoun", isVisible: false)]
        words += [(word: "exciting", type: "adjective", isVisible: false)]
        words += [(word: "green", type: "adjective", isVisible: false)]
        words += [(word: "tidy", type: "adjective", isVisible: false)]
        words += [(word: "jump", type: "verb", isVisible: false)]
        words += [(word: "stop", type: "verb", isVisible: false)]
        words += [(word: "explore", type: "verb", isVisible: false)]
        words += [(word: "snow", type: "verb", isVisible: false)]
        words += [(word: "happen", type: "verb", isVisible: false)]
        words += [(word: "happen", type: "verb", isVisible: false)]
        words += [(word: "be", type: "verb", isVisible: false)]
        words += [(word: "evolve", type: "verb", isVisible: false)]
        words += [(word: "shrink", type: "verb", isVisible: false)]
        words += [(word: "widen", type: "verb", isVisible: false)]
        words += [(word: "man", type: "noun", isVisible: false)]
        words += [(word: "girl", type: "noun", isVisible: false)]
        words += [(word: "engineer", type: "noun", isVisible: false)]
        words += [(word: "horse", type: "noun", isVisible: false)]
        words += [(word: "wall", type: "noun", isVisible: false)]
        words += [(word: "flower", type: "noun", isVisible: false)]
        words += [(word: "life", type: "noun", isVisible: false)]
        words += [(word: "death", type: "noun", isVisible: false)]
        
        
        placeWords()
    }
    
    func removeWords(){
        for v in view.subviews{
            if (v is UILabel){
                v.removeFromSuperview()
            }
        }
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
            label.text = word.word
            label.font = UIFont(name: "HelveticaNeue", size: 40.0)
            label.sizeToFit()
            label.directionalLayoutMargins.bottom = 5
            label.directionalLayoutMargins.top = 5
            label.directionalLayoutMargins.leading = 50
            //label.directionalLayoutMargins.trailing = 50
            //label.sizeToFit()
            
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

