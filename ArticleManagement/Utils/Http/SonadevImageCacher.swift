//
//  SonadevImageCacher.swift
//  ArticleManagement
//
//  Created by sophatvathana on 11/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import UIKit

class SonadevImageCacher: NSObject, URLSessionTaskDelegate {
    
    class var sharedInstance: SonadevImageCacher {
        struct Singleton {
            static let instance = SonadevImageCacher()
        }
        return Singleton.instance
    }
    
    var session:URLSession!
    var urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "ImageDownloadCache")
    var downloadQueue = Dictionary<URL, (UIImage?, Error?)->()?>()
    
    override init() {
        super.init()
        
        let config = URLSessionConfiguration.default
        
        config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        config.urlCache = urlCache
        
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func getImageFromCache(url:URL, completion:@escaping (UIImage?, Error?)->()) {
        let urlRequest = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
        if let response = urlCache.cachedResponse(for: urlRequest) {
            let image = UIImage(data: response.data)
            DispatchQueue.main.async {
                () -> Void in
                completion(image, nil)
                return
            }
        } else {
            completion(nil, nil)
        }
    }
    
    func getImage(url:URL, completion:((UIImage?, Error?)->())?) {
        
        let urlRequest = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
        
        if let response = urlCache.cachedResponse(for: urlRequest) {
            let image = UIImage(data: response.data)
            DispatchQueue.main.async {
                () -> Void in
                completion?(image, nil)
                return
            }
        } else {
            let task = self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) -> Void in
                if let strongSelf = self {
                    if let completionHandler = strongSelf.downloadQueue[url] {
                        if let errorReceived = error {
                            //							println("ERROR >>>>>>>>> \(errorReceived.localizedFailureReason)")
                            DispatchQueue.main.async {
                                completionHandler(nil, nil)
                                return
                            }
                        } else {
                            if let httpResponse = response as? HTTPURLResponse {
                                if httpResponse.statusCode >= 400 {
                                    completionHandler(nil, NSError(domain: NSURLErrorDomain, code: httpResponse.statusCode, userInfo: nil))
                                } else {
                                    //									println(" >>>>>>>>> LENGTHS: \(response.expectedContentLength) - got: \(data.length)")
                                    strongSelf.urlCache.storeCachedResponse(CachedURLResponse(response:response!, data:data!, userInfo:nil, storagePolicy:URLCache.StoragePolicy.allowed), for: urlRequest)
                                    
                                    let image = UIImage(data: data!)
                                    DispatchQueue.main.async {
                                        completionHandler(image, nil)
                                        return
                                    }
                                }
                            }
                        }
                    }
                    strongSelf.cancelImage(requestUrl: url)
                }
            }
            addToQueue(url: url, task, completion: completion)
        }
    }
    
    func cancelImage(requestUrl:URL?) {
        if let url = requestUrl {
            if let index = self.downloadQueue.index(forKey: url) {
                self.downloadQueue.remove(at: index)
            }
        }
    }
    
    
    // MARK: - Private
    
    private func addToQueue(url:URL, _ task:URLSessionDataTask, completion:((UIImage?, Error?)->())?) {
        self.downloadQueue[url] = completion
        if task.state != .running {
            task.resume()
        }
    }
}
