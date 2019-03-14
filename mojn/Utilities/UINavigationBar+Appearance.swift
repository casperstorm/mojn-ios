//
//  UINavigationBar+Appearance.swift
//  mojn
//
//  Created by Casper Rogild Storm on 12/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    class func setupGlobalAppearance() {
        self.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "PatuaOne-Regular", size: 32)!]
        
        self.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "PatuaOne-Regular", size: 22)!]
        
        self.appearance().isTranslucent = false
        self.appearance().shadowImage = UIImage()
    }
    
    class func tintColor (color: UIColor) {
        self.appearance().barTintColor = color
    }
}
