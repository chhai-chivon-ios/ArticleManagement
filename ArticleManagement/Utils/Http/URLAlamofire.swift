//
//  URLAlamofire.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

private let kKeyMessage      = "message"
private let kKeyData         = "data"
private let kKeyCode         = "code"

extension Alamofire.DataRequest {
    @discardableResult
    //    static func responseFileUploadSwiftyJSON(completionHandler: (Alamofire.Result) -> Void) -> Self {
    //        return response(responseSerializer: DataRequest.fileUploadSwiftyJSONResponseSerializer(), completionHandler)
    ////        return response(responseSerializer: <#T##T#>, completionHandler: <#T##(DataResponse<T.SerializedObject>) -> Void#>)
    //    }
    
    static func fileUploadResponseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { request, response, data, error in
            guard error == nil else {
                let failureReason = "Network is not working, please try again later :）"
                let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
                let error = NSError(domain: "", code: 9999, userInfo: userInfo)
                return .failure(error)
            }
            
            guard let validData = data, validData.count > 0 else {
                let failureReason = "Data error, please try again later:）"
                let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
                let error = NSError(domain: "", code: 9999, userInfo: userInfo)
                return .failure(error)
            }
            
            let json: JSON = SwiftyJSON.JSON(data: validData)
            if let jsonError = json.error {
                return Result.failure(jsonError)
            }
            
            let code = json[kKeyCode].intValue
            if code == 9999 {
                let userInfo = [NSLocalizedFailureReasonErrorKey: json["message"].stringValue]
                let error = NSError(domain: "", code: 9999, userInfo: userInfo)
                return .failure(error)
            }
            
            return Result.success(json)
        }
    }
}
