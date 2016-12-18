//
//  UploadManager.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension HttpManager {

    class func uploadSingleImage(
        _ image:UIImage,
        success:@escaping (_ imageModel: UploadImage) ->Void,
        failure:@escaping (Void) ->Void)
    {
//        let parameters = [
//            "":""
//        ]
        let headers = [
            "Authorization": Config.TOKEN
            //"Accept": "application/json"
        ]
        
        let imageData = UIImageJPEGRepresentation(image, 0.7)
      
        let uploadIImageURLString = "\(Config.API_URL)uploadfile/single"
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if imageData != nil {
                    multipartFormData.append(imageData!, withName: "FILE", fileName: "test.png", mimeType: "image/png")
                }
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
        },
            to: uploadIImageURLString,
            method: .post, headers: headers,
            encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let data):
                        
                            let model: UploadImage = AMMapper<UploadImage>().map(JSONObject:data)!
                            success(model)
                        case .failure( _):
                            failure()
                        }
                    }
                case .failure(let encodingError):
                    debugPrint(encodingError)
                }
        })
    }
    
    class func uploadMultipleImages(
        _ imagesArray:[UIImage],
        success:@escaping (_ imageModel: [UploadImage], _ imagesId: String) ->Void,
        failure:@escaping (Void) ->Void)
    {
        guard imagesArray.count != 0 else {
            assert(imagesArray.count == 0, "Invalid images array") // here
            failure()
            return
        }
        
        for image in imagesArray {
            guard image.isKind(of: UIImage.self) else {
                failure()
                return
            }
        }
        
        
        let resultImageIdArray = NSMutableArray()
        let resultImageModelArray = NSMutableArray()
        
        let emtpyId = ""
        for _ in 0..<imagesArray.count {
            resultImageIdArray.add(emtpyId)
        }
        
        let group = DispatchGroup()
        var index = 0
        for (image) in imagesArray {
            group.enter();
            self.uploadSingleImage(
                image,
                success: {model in
                    let imageData = model.data
                    resultImageIdArray.replaceObject(at: index, with: imageData!)
                    resultImageModelArray.add(model)
                    group.leave();
            },
                failure: {
                    group.leave();
            }
            )
            index += 1
        }
        
        group.notify(queue: DispatchQueue.main, execute: {
            let checkIds = resultImageIdArray as NSArray as! [String]
            for imageId: String in checkIds {
                if imageId == emtpyId {
                    failure()
                    return
                }
            }
            
            let ids = resultImageIdArray.componentsJoined(by: ",")
            let images = resultImageModelArray as NSArray as! [UploadImage]
            success(images, ids)
        })
    }
    class func uploadImagesMultiParamOfImage(_ images:[UIImage],
    success:@escaping (_ imageModel: UploadImage) ->Void,
    failure:@escaping (Void) ->Void)
    {
             let parameters = [
                "name":"TestRespanrant"
            ]
        let headers = [
            "Authorization": Config.PHOTOS_TOKEN
            //"Accept": "application/json"
        ]
    
        
        let uploadIImageURLString = "\(Config.API_URL_PHOTOS)admin/upload/multiple"
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                    for image in images {
                        let imageData = UIImageJPEGRepresentation(image, 0.7)
                        multipartFormData.append(imageData!, withName: "files", fileName: "test.png", mimeType: "image/png")
                    }
                    for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
        },
            to: uploadIImageURLString,
            method: .post, headers: headers,
            encodingCompletion: { result in
                switch result {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            switch response.result {
                            case .success(let data):
    
                                let model: UploadImage = AMMapper<UploadImage>().map(JSONObject:data)!
                                success(model)
                            case .failure( _):
                                failure()
                            }
                    }
                case .failure(let encodingError):
                    debugPrint(encodingError)
                }
        })
    }
}




