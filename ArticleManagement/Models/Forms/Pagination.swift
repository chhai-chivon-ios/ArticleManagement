//
//  Pagination.swift
//  ArticleManagement
//
//  Created by sophatvathana on 18/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import ObjectMapper

struct Pagination:Mappable {
    
    var page:Int?
    var limit:Int?
    var total_count:Int?
    var total_pages:Int?

    init?(map: Map) {
        
    }
}
extension Pagination {
    mutating func mapping(map: Map) {
        page            <-  map["PAGE"]
        limit           <-  map["LIMIT"]
        total_count     <- map["TOTAL_COUNT"]
        total_pages     <- map["TOTAL_PAGES"]
    }
    
}
