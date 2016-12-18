//
//  ArticleService.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation

class ArticleService {
    
    private var articles = [Article]()
    
    func getArticles(page:Int, limit:Int,callBack:@escaping ([Article],Pagination) -> Void){
        
        let session = URLSession(configuration: .default)
        session.synTask(url: URL(string:"\(Config.API_URL)articles?page=\(page)&limit=\(limit)")!, completionHandler: {
            data, response, error in
            if error == nil{
                let datajson = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.articles.removeAll()
                for data in datajson["DATA"] as! [Any] {
                    self.articles.append(Article(JSON: data as! [String:Any])!)
                }
                
                callBack(self.articles,Pagination(JSON: datajson["PAGINATION"] as! [String:Any])!)
            }
        })
        
    }
    func deleteArticle(id:Int, callBack:(String)->Void){
        let session = URLSession(configuration: .default)
        session.synTask(url: URL(string:"\(Config.API_URL)articles/\(id)")!, "DELETE", completionHandler: {
            data, response, error in
            if error == nil{
               let datajson = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                callBack(datajson["MESSAGE"] as! String)
            }
        })
    }
}
