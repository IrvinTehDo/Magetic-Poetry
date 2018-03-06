//
//  WordSetBrain.swift
//  Word River
//
//  Created by IrvinTehDo on 3/5/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import Foundation
import UIKit

protocol WordSetBrainDelegate{
    func wordSetBrain(didChange wordSetBrain: WordSetBrain, userSet: [UserSetData] )
}

class WordSetBrain {
    private var dataModel: WordSetModel
    
    var delegate: WordSetBrainDelegate?
    
    var categoryString: String {
        get {
            //never nil, no need to check
                return dataModel.category
        } set {
            print("Setting new Category Value \(newValue)")
            dataModel.category = newValue
        }
    }

    var userSetDataArray: [UserSetData] {
        get {
            return dataModel.userSetDataArray
        }

        set {
            print("Setting New Value")
            dataModel.userSetDataArray = newValue
            delegate?.wordSetBrain(didChange: self, userSet: newValue)

        }
    }
    
    init(dataModel: WordSetModel = WordSetModelUserDefaults()) {
        self.dataModel = dataModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    func updateLabelPosistions(labels: [UILabel]) {
        for i in 0...(labels.count - 1) {
            print(i)
            print(labels[i].center.x)
            print(labels[i].center.y)
            dataModel.userSetDataArray[i].centerX = Int(labels[i].center.x)
            dataModel.userSetDataArray[i].centerY = Int(labels[i].center.y)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func applicationDidEnterBackground(_ application: UIApplication){
        dataModel.save()
    }
}
