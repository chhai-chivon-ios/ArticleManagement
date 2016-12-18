//
//  UserService.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation

class UserService {
    
    //the service delivers mocked data with a delay
    private var user:User?
    func getUsers(callBack:@escaping (User) -> Void){
//        let users = [User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:""),
//                     User( id:1, name:"Sovathana", email:"sovathana.phat@gmail.com", gender:"Male", telephone:"092789264"
//                        ,status:"", facebookId:"12312312", imageUrl:"")
//        ]
        let url = URL(string: "\(Config.API_URL)users/1201")
        let session = URLSession(configuration: .default)
        session.synTask(url: url!, completionHandler: {
            data, response, error in
            if error == nil{
    
                let datajson = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.user =  User(JSON:datajson["DATA"] as! [String:Any])
                callBack(self.user!)
            }
        })
        
    }
}
