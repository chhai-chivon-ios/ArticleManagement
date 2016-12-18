//
//  ArticleMNImageDI.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIImage
    typealias Image = UIImage
#elseif os(OSX)
    import AppKit.NSImage
    typealias Image = NSImage
#endif

enum ArticleMNImageDI: String {
    case newsfeed_normal = "newsfeed_normal"
    case newsfeed_selected = "newsfeed_selected"
    case writer_normal = "writer_normal"
    case back_icon = "back_icon"
    case barbuttonicon_add = "barbuttonicon_add"
    case articleRightTopBg = "articleRightTopBg"
    case noimage = "noimage"
    case upload_file = "upload_file"
    
    var image: Image {
        return Image(asset: self)
    }
}


extension Image {
    convenience init!(asset: ArticleMNImageDI) {
        self.init(named: asset.rawValue)
    }
}

