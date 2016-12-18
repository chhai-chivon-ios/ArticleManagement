//
//  HttpManager.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation

public typealias ts_parameters = [String : AnyObject]
public typealias SuccessClosure = (AnyObject) -> Void
public typealias FailureClosure = (Error) -> Void

class HttpManager: NSObject {
    class var sharedInstance : HttpManager {
        struct Static {
            static let instance : HttpManager = HttpManager()
        }
        return Static.instance
    }
    
    fileprivate override init() {
        super.init()
    }
}
