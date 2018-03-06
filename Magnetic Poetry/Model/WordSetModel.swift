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
    var wordSets:[(name: String, value: [String])] { get set }
    var userSetDataArray:[UserSetData] {get set}
    func setAndAppend(words: [(String)])
    var category: String { get set }
    
    func save()
    func load()
}

//Word Set is the Word Sets predefined in our constants.

// User Set is the current of words the user is working with holding the text and posistions.

let kWordSetKey = "kWordSetKey"
let kUserSetKey = "kUserSetKey"
let kCategoryKey = "kCategoryKey"

struct Constants{
    struct WordSetModel {
        static let defaultWordSets:[(name: String, value: [String])] = [(name: "Default",value: [" a ", " a ", " & " , " & ", "about", "above", "ache", "am", "am", "and", "and", "because", "but", "for", "if", "he", "or", "he", "she", "they", " I ", "you", "me", "them", "exciting", "green", "tidy", "jump", "stop", "explore", "snow", "happen", "happen", "be", "evolve", "shrink", "widen", "man", "girl",   "engine", "horse", "wall", "flower", "life", "death"]), (name: "Pirates", value: [" a ", " a ", " a ", "aye", "aye", "avast ye", "ask", "Davey Jones", "chest", "barnacle", "fortune", "treasure", " & ", "thirsty", "this", "this", "shiver", "me", "me", "timbers", "pirate", "plank", "pirate", " I ", " I ", "sword", "plank", "secret", "search", "matey", "avast", "scurvy", "locker", "plank", "plunder", "gold", "feed", "fight", "walk the", "shoot", "swing"]), (name: "Space", value: ["rocket", "laser", "spaceship", "UFO", "alien", "galaxy", "planet", " a ", " a ", " a ", " & ",  " & ", " I ", " I ", "earth", "moon", "black", "abyss", "void", "hole", "asteroid", "comet", "meteor", "cold", "gravity", "zero", "boots", "suit", "space", "space", "lasers", "blaster", "fuel", "gravity", "pulls", "me"])]
    }
    
    static let defaultCategory: String = "Default"
}

class WordSetModelUserDefaults: WordSetModel {
    
    let defaults: UserDefaults
    
    var wordSets: [(name: String, value: [String])]
    
    var userSetDataArray: [UserSetData] = []
    
    var category: String
    
    init(userDefaults: UserDefaults = UserDefaults.standard){
        defaults = userDefaults
        wordSets = Constants.WordSetModel.defaultWordSets
        category = Constants.defaultCategory
        load()
    }
    
    
    //this is for you irvin I love you 
    func setAndAppend(words: [(String)]) {
        userSetDataArray = []
        var xPlacement = 80
        var yPlacement = 50
        var yBuffer = 50
        let margin = 35

        //Determine font size based on device being used
        //Also adjust yPlacement
        //Default - phone and others
        var fontSize:CGFloat = 40

        //If they're using an ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            fontSize = 65
        }
            //If they're using a tv...
        else if UIDevice.current.userInterfaceIdiom == .tv {
            fontSize = 200
        }
        //yBuffer will space the words vertically to compensate for large fontSize
        yBuffer = Int(fontSize) + 20

        for words in words {
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = words
            label.font = UIFont(name: "HelveticaNeue", size: fontSize)
            label.sizeToFit()

            if label.frame.width + CGFloat(margin) + CGFloat(xPlacement) > UIScreen.main.bounds.width {
                xPlacement = 80
                yPlacement += yBuffer
            }

            let x = margin + Int(xPlacement)
            xPlacement = x + Int(label.frame.width)

            let y = yPlacement
            label.center = CGPoint(x:x, y:y)
            
            if ( y <= Int(UIScreen.main.bounds.height / 3)  ) {
                userSetDataArray.append(UserSetData(text: label.text!, centerX: Int(label.center.x), centerY: Int(label.center.y)))
            }
        }
    }
    
    func makeUserSetArchive(userSetData: [UserSetData]) -> NSData{
        return NSKeyedArchiver.archivedData(withRootObject: userSetData as NSArray) as NSData
    }
    
    
    func save() {
        let toSave = makeUserSetArchive(userSetData: userSetDataArray)
        defaults.set(toSave, forKey: kUserSetKey)
        
        defaults.set(category, forKey: kCategoryKey)
    }
    
    func load() {
        self.wordSets = Constants.WordSetModel.defaultWordSets

        if let category = defaults.value(forKey: kCategoryKey) as? String {
            self.category = category
        } else {
            self.category = "Default"
        }
        

        for sets in wordSets {
            if sets.name == category {
                setAndAppend(words: sets.value)
                break;
            }
        }
        
        if let userSetData = defaults.object(forKey: kUserSetKey) as? Data{
            self.userSetDataArray = (NSKeyedUnarchiver.unarchiveObject(with: userSetData as Data) as? [UserSetData])!
        } else {
            setAndAppend(words: wordSets[0].value)
        }
    }
}
