//
//  WordSetVC.swift
//  Word River
//
//  Created by IrvinTehDo on 2/19/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import UIKit

class WordSetVC: UITableViewController {
    
    var wordSets:[(name: String, value: [String])] = []
    
    let defaultWords = [" a ", " a ", " & " , " & ", "about", "above", "ache", "am", "am", "and", "and", "because", "but", "for", "if", "he", "or", "he", "she", "they", " I ", "you", "me", "them", "exciting", "green", "tidy", "jump", "stop", "explore", "snow", "happen", "happen", "be", "evolve", "shrink", "widen", "man", "girl",   "engine", "horse", "wall", "flower", "life", "death"]
    
    let pirateWords = [" a ", " a ", " a ", "aye", "aye", "avast ye", "ask", "Davey Jones", "chest", "barnacle", "fortune", "treasure", " & ", "thirsty", "this", "this", "shiver", "me", "me", "timbers", "pirate", "plank", "pirate", " I ", " I ", "sword", "plank", "secret", "search", "matey", "avast", "scurvy", "locker", "plank", "plunder", "gold", "feed", "fight", "walk the", "shoot", "swing"]
    
    let spaceWords = ["rocket", "laser", "spaceship", "UFO", "alien", "galaxy", "planet", " a ", " a ", " a ", " & ",  " & ", " I ", " I ", "earth", "moon", "black", "abyss", "void", "hole", "asteroid", "comet", "meteor", "cold", "gravity", "zero", "boots", "suit", "space", "space", "lasers", "blaster", "fuel", "gravity", "pulls", "me"]
    
    var selectedWordSet:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a Word Set"
        
        wordSets.append((name: "Default", value: defaultWords))
        wordSets.append((name: "Pirates", value: pirateWords))
        wordSets.append((name: "Space", value: spaceWords))
        
        selectedWordSet = wordSets[0].value
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordSets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let tuple = wordSets[indexPath.row]
        let name = tuple.name
        
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordSet = wordSets[indexPath.row].value
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

