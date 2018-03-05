//Kyle Lekkas and Irvin Do
//  UIView+takeSnapshot.swift
//  Word River
//
//  Created by Student on 3/4/18.
//  Copyright © 2018 Irvin Do. All rights reserved.
//
//
//Extension for saving screen in application

import UIKit

extension UIView {
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
