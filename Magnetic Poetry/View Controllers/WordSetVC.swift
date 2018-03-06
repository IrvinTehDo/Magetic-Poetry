//
//  WordSetVC.swift
//  Word River
//
//  Created by IrvinTehDo on 2/19/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import UIKit

class WordSetVC: UITableViewController {

    var wordSetBrain: WordSetBrain!
    var selectedWordSet:[String]!
    var selectedCategory: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a Word Set"
        
        selectedWordSet = Constants.WordSetModel.defaultWordSets[0].value
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.WordSetModel.defaultWordSets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let tuple = Constants.WordSetModel.defaultWordSets[indexPath.row]
        let name = tuple.name
        
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordSet = Constants.WordSetModel.defaultWordSets[indexPath.row].value
        selectedCategory = Constants.WordSetModel.defaultWordSets[indexPath.row].name
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

