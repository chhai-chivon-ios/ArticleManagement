//
//  HttpExtension.swift
//  ArticleManagement
//
//  Created by sophatvathana on 15/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
extension URLSession {
    typealias CompletionHandler = (_ data:Data?, _ response:URLResponse?, _ error:Error?)->Void
    func synTask(url: URL, _ method:String = "GET",completionHandler:CompletionHandler){
        
        var data: Data?, response: URLResponse?, error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        var urlRequest:URLRequest = URLRequest(url: url)
        urlRequest.addValue(Config.TOKEN, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = method
        dataTask(with: urlRequest) {
            data = $0; response = $1; error = $2
            semaphore.signal()
            }.resume()
        
        semaphore.wait()
        
        completionHandler(data, response, error)
    }
    
    func synTask(url: URL, _ method:String = "PUT", withData:Data, completionHandler:@escaping CompletionHandler) {
        var data: Data?, response: URLResponse?, error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        var urlRequest:URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.addValue(Config.TOKEN, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
        urlRequest.httpBody = withData

        dataTask(with: urlRequest) {
            data = $0; response = $1; error = $2
             semaphore.signal()
            }.resume()
        
        semaphore.wait()
        
        completionHandler(data, response, error)
    }
    
    
}
