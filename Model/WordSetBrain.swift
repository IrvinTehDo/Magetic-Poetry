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
    func wordSetBrain(didChange wordSetBrain: WordSetBrain, userSet: [(text: NSString, centerX: NSNumber, centerY: NSNumber)] )
}

class WordSetBrain {
    private var dataModel: WordSetModel
    
    var delegate: WordSetBrainDelegate?
    
    var categoryString: String {
        get {
            //never nil, no need to check
                return dataModel.category
        }
    }

//    var userSetData: [(text: NSString, centerX: NSNumber, centerY: NSNumber)] {
//        get {
//            return dataModel.userSetData
//        }
//
//        set {
//            print("Setting New Value")
//            dataModel.userSetData = newValue
//            delegate?.wordSetBrain(didChange: self, userSet: newValue)
//
//        }
//    }
    
    init(dataModel: WordSetModel = WordSetModelUserDefaults()) {
        self.dataModel = dataModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func applicationDidEnterBackground(_ application: UIApplication){
        dataModel.save()
    }
}
