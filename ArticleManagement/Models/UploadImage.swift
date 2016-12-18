//
//  UploadImage.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import ObjectMapper
struct UploadImage:Mappable {
    var code:String?
    var message:String?
    var data:String?
    init?(map: Map) {
        
    }
}
extension UploadImage {
    mutating func mapping(map: Map) {
        code    <- map["CODE"]
        message <- map["MESSAGE"]
        data    <- map["DATA"]
    }

}
