//
//  UserSetData.swift
//  Word River
//
//  Created by IrvinTehDo on 3/5/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//

import Foundation

let kTextKey = "kTextKey"
let kCenterXKey = "kCenterXKey"
let kCenterYKey = "kCenterYKey"

class UserSetData: NSObject, NSCoding {
    
    var text: String?
    var centerX: Int?
    var centerY: Int?
    
    required init(text: String, centerX: Int, centerY: Int) {
        self.text = text
        self.centerX = centerX
        self.centerY = centerY
    }
    
    required init(coder decoder: NSCoder) {
        text = decoder.decodeObject(forKey: kTextKey) as? String
        centerX = (decoder.decodeObject(forKey: kCenterXKey) as! Int)
        centerY = (decoder.decodeObject(forKey: kCenterYKey) as! Int)
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(text, forKey: kTextKey)
        encoder.encode(centerX, forKey: kCenterXKey)
        encoder.encode(centerY, forKey: kCenterYKey)
    }
}
