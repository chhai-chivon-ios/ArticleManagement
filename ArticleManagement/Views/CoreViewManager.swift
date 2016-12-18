//
//  CoreViewManager.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import UIKit

class CoreViewManager {
    static func applicationConfigInit() {
        self.initNavigationBar()
    }
    
    static func initNavigationBar() {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = true
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 19.0),
            NSForegroundColorAttributeName: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }

}
