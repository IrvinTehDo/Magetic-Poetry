//
//  WordSetBrain.swift
//  Word River
//
//  Created by Irvin Do and Kyle Lekkas on 3/5/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import Foundation
import UIKit

protocol WordSetBrainDelegate{
    func wordSetBrain(didChange wordSetBrain: WordSetBrain, userSet: [UserSetData] )
}

// Where all the logic happens and for the view controller to communicate.
class WordSetBrain {
    private var dataModel: WordSetModel
    
    var delegate: WordSetBrainDelegate?
    
    //Grabs and set what category the user is in.
    var categoryString: String {
        get {
            //never nil, no need to check
                return dataModel.category
        } set {
            print("Setting new Category Value \(newValue)")
            dataModel.category = newValue
        }
    }
    // Returns the current array and the center locations of the labels.
    var userSetDataArray: [UserSetData] {
        get {
            return dataModel.userSetDataArray
        }

        set {
            dataModel.userSetDataArray = newValue
            delegate?.wordSetBrain(didChange: self, userSet: newValue)

        }
    }
    
    init(dataModel: WordSetModel = WordSetModelUserDefaults()) {
        self.dataModel = dataModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Update our posistions to our dataModel based on where the labels are on the view.
    func updateLabelPosistions(labels: [UILabel]) {
        for i in 0...(labels.count - 1) {
            dataModel.userSetDataArray[i].centerX = Int(labels[i].center.x)
            dataModel.userSetDataArray[i].centerY = Int(labels[i].center.y)
        }
    }
    
    @objc func applicationDidEnterBackground(_ application: UIApplication){
        dataModel.save()
    }
}
