//
//  WordSetModel.swift
//  Word River
//
//  Created by IrvinTehDo on 3/5/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import Foundation
import UIKit
protocol WordSetModel{
//    var wordSets:[(name: String, value: [String])] { get set }
//    var userSetData:[(text: NSString, centerX: NSNumber, centerY: NSNumber)] {get set}
//    func setAndAppend(words: [(String)])
    var category: String { get set }
    
    func save()
    func load()
}

//Word Set is the Word Sets predefined in our constants.

// User Set is the current of words the user is working with holding the text and posistions.

//let kWordSetKey = "kWordSetKey"
//let kUserSetKey = "kUserSetKey"
let kCategoryKey = "kCategoryKey"

struct Constants{
    struct WordSetModel {
        static let defaultWordSets:[(name: String, value: [String])] = [(name: "Default",value: [" a ", " a ", " & " , " & ", "about", "above", "ache", "am", "am", "and", "and", "because", "but", "for", "if", "he", "or", "he", "she", "they", " I ", "you", "me", "them", "exciting", "green", "tidy", "jump", "stop", "explore", "snow", "happen", "happen", "be", "evolve", "shrink", "widen", "man", "girl",   "engine", "horse", "wall", "flower", "life", "death"]), (name: "Pirates", value: [" a ", " a ", " a ", "aye", "aye", "avast ye", "ask", "Davey Jones", "chest", "barnacle", "fortune", "treasure", " & ", "thirsty", "this", "this", "shiver", "me", "me", "timbers", "pirate", "plank", "pirate", " I ", " I ", "sword", "plank", "secret", "search", "matey", "avast", "scurvy", "locker", "plank", "plunder", "gold", "feed", "fight", "walk the", "shoot", "swing"]), (name: "Space", value: ["rocket", "laser", "spaceship", "UFO", "alien", "galaxy", "planet", " a ", " a ", " a ", " & ",  " & ", " I ", " I ", "earth", "moon", "black", "abyss", "void", "hole", "asteroid", "comet", "meteor", "cold", "gravity", "zero", "boots", "suit", "space", "space", "lasers", "blaster", "fuel", "gravity", "pulls", "me"])]
    }
    
    static let defaultCategory: String = "Default"
}

class WordSetModelUserDefaults: WordSetModel {
    
    let defaults: UserDefaults
    
    //var wordSets: [(name: String, value: [String])]
    
    //var userSetData: [(text: NSString, centerX: NSNumber, centerY: NSNumber)] = []
    
    var category: String
    
    init(userDefaults: UserDefaults = UserDefaults.standard){
        defaults = userDefaults
        //wordSets = Constants.WordSetModel.defaultWordSets
        //setAndAppend(words: wordSets[0].value)
        
        category = Constants.defaultCategory
        
        load()
    }
    
    //this is for you irvin I love you 
//    func setAndAppend(words: [(String)]) {
//        userSetData = []
//        var xPlacement = 80
//        var yPlacement = 50
//        var yBuffer = 50
//        let margin = 35
//
//        //Determine font size based on device being used
//        //Also adjust yPlacement
//        //Default - phone and others
//        var fontSize:CGFloat = 40
//
//        //If they're using an ipad
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            fontSize = 65
//        }
//            //If they're using a tv...
//        else if UIDevice.current.userInterfaceIdiom == .tv {
//            fontSize = 200
//        }
//        //yBuffer will space the words vertically to compensate for large fontSize
//        yBuffer = Int(fontSize) + 20
//
//        for words in wordSets[0].value {
//            let label = UILabel()
//            label.backgroundColor = UIColor.white
//            label.text = words
//            label.font = UIFont(name: "HelveticaNeue", size: fontSize)
//            label.sizeToFit()
//
//            if label.frame.width + CGFloat(margin) + CGFloat(xPlacement) > UIScreen.main.bounds.width {
//                xPlacement = 80
//                yPlacement += yBuffer
//            }
//
//            let x = margin + Int(xPlacement)
//            xPlacement = x + Int(label.frame.width)
//
//            let y = yPlacement
//            label.center = CGPoint(x:x, y:y)
//            userSetData.append((words as NSString, label.center.x as NSNumber, label.center.y as NSNumber))
//        }
//    }
    
    func save() {
        //defaults.set(wordSets, forKey: kWordSetKey)
        
        //let toSave = NSKeyedArchiver.archivedData(withRootObject: userSetData as NSArray) as NSData
        
        defaults.set(category, forKey: kCategoryKey)
    }
    
    func load() {
//        if let wordSets = defaults.value(forKey: kWordSetKey) as? [(name: String, value: [String])]{
//            self.wordSets = wordSets
//        } else {
//            self.wordSets = Constants.WordSetModel.defaultWordSets
//        }
        
//        if let userSetData = defaults.value(forKey: kUserSetKey) as? Data{
//            self.userSetData = (NSKeyedUnarchiver.unarchiveObject(with: userSetData as Data) as? [(text: NSString, centerX: NSNumber, centerY: NSNumber)])!
//        } else {
//            setAndAppend(words: wordSets[0].value)
//        }
        
        if let category = defaults.value(forKey: kCategoryKey) as? String {
            self.category = category
        } else {
            self.category = "Default"
        }
    }
}
