//
//  UIColorArticle.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//
import UIKit
import Foundation

extension UIColor {
    class var barTintColor: UIColor {
        get {return UIColor.blue }
    }
    
    class var tabbarSelectedTextColor: UIColor {
        get {return UIColor.red }
    }
    
    class var viewBackgroundColor: UIColor {
        get {return UIColor.init(tc_hexString: "#E7EBEE")}
    }
    
    class var borderColorImage: UIColor {
        get {return UIColor.init(tc_hexString: "#ddd")}
    }
}
