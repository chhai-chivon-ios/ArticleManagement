//
//  UserPresenter.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation

struct UserViewData{
    let id:Int
    let name: String
    let email:String
    let gender:String
    let telephone:String
    let status:String
    let facebookId:String
    let imageUrl:String
}

protocol UserView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setUser(user: UserViewData)
    func setEmptyUser()
}

class UserPresenter {
    private let userService:UserService
    weak private var userView : UserView?
    
    init(userService:UserService){
        self.userService = userService
    }
    
    func attachView(view:UserView){
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getUser(){
        self.userView?.startLoading()
        userService.getUsers{ [weak self] user in
            print(user)
            self?.userView?.finishLoading()
            if user == nil {
                self?.userView?.setEmptyUser()
            }else{
                self?.userView?.setUser(user: UserViewData(id:user.id!,name: user.name!
                    , email: user.email!, gender: user.gender!, telephone: user.telephone!, status: user.status!, facebookId: user.facebookId!, imageUrl: user.imageUrl!))
            }
            
        }
    }
}
