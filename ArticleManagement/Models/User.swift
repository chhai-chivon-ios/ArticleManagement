//
//  User.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import ObjectMapper

struct User:Mappable {

    var id:Int?
    var name:String?
    var email:String?
    var gender:String?
    var telephone:String?
    var status:String?
    var facebookId:String?
    var imageUrl:String?
    
    init?(map: Map) {
        
    }
}
extension User {
    mutating func mapping(map: Map) {
        id <- map["ID"]
        name <- map["NAME"]
        email <- map["EMAIL"]
        gender <- map["GENDER"]
        telephone   <- map["TELEPHONE"]
        status      <- map["STATUS"]
        facebookId  <- map["FACEBOOK_ID"]
        imageUrl    <- map["IMAGE_URL"]
        
    }
    
}
