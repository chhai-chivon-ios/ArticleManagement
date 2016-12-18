//
//  Article.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import ObjectMapper

struct Article:Mappable {
    var id:Int?
    var title:String?
    var description:String?
    var createdDate:String?
    var author:User?
    var status:String?
    var category:Category?
    var image:String?
    init?(map: Map) {
        
    }
}

extension Article {
    mutating func mapping(map: Map) {
        id          <- map["ID"]
        title       <- map["TITLE"]
        description <- map["DESCRIPTION"]
        createdDate <- map["CREATED_DATE"]
        author      <- map["AUTHOR"]
        status      <- map["STATUS"]
        category    <- map["CATEGORY"]
        image       <- map["IMAGE"]
    }
    
}
