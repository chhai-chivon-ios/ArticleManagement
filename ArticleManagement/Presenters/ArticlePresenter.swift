//
//  ArticlePresenter.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
class ArticlePresenter {
    private let articleService:ArticleService
    weak private var articleView : ArticleView?
    
    init(articleService:ArticleService){
        self.articleService = articleService
    }
    
    func attachView(view:ArticleView){
        articleView = view
    }
    
    func detachView() {
        articleView = nil
    }
    
    func getArticles(page:Int, limit:Int){
        self.articleView?.startLoading()
        articleService.getArticles(page: page, limit: limit){ [weak self] articles, pagination in
            self?.articleView?.finishLoading()
            if(articles.count == 0){
                self?.articleView?.setEmptyArticles()
            }else{
                let mappedArticles = articles.map{
                    return ArticleViewData(id: $0.id, title: $0.title, description: $0.description, createdDate: $0.createdDate, author: $0.author, status: $0.status, category: $0.category, image: $0.image)
                }
                self?.articleView?.setArticle(articles:mappedArticles,pagination: pagination)
            }
            
        }
    }
    
    func deleteArticle(id:Int){
        self.articleView?.startLoading()
        //articleService.deleteArticle(id: <#T##Int#>, callBack: <#T##(String) -> Void#>)
    }
}

struct ArticleViewData {
    var id:Int?
    var title:String?
    var description:String?
    var createdDate:String?
    var author:User?
    var status:String?
    var category:Category?
    var image:String?
}

protocol ArticleView:NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setArticle(articles: [ArticleViewData], pagination:Pagination)
    func setEmptyArticles()
    //func deleteArticle(id:Int, )
}

