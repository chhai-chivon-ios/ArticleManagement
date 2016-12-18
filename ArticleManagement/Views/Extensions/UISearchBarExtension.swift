//
//  UISearchBarExtension.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import UIKit
extension UISearchBar {
    
    var cancelButton: UIButton {
        get {
            var button = UIButton()
            for view in self.subviews {
                for subView in view.subviews {
                    if subView.isKind(of: UIButton.self) {
                        button = subView as! UIButton
                        return button
                    }
                }
            }
            return button
        }
    }
}
