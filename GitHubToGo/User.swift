//
//  User.swift
//  GitHubToGo
//
//  Created by Sam Wong on 22/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class User {
    var login : String
    var id : Int
    var avatarURL : String
    var URL : String
    var reposURL : String
    var avatarImage: UIImage!
    
    init(login : String, id : Int, avatarURL : String, URL : String, reposURL : String) {
        self.login = login
        self.id = id
        self.avatarURL = avatarURL
        self.URL = URL
        self.reposURL = reposURL
    }
    
    class func parseJSONDataIntoUser(rawJSONData : NSData) -> [User]? {
        var error : NSError?
        var users = [User]()
        
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options : nil, error : &error) as? NSDictionary {
            if error != nil {
                println(error)
                return nil
            }
            
            if let itemArray = JSONDictionary["items"] as? NSArray {
                for object in itemArray {
                    if let item = object as? NSDictionary {
                        let login = item["login"] as String
                        let id = item["id"] as Int
                        let avatarURL = item["avatar_url"] as String
                        let URL = item["url"] as String
                        let reposURL = item["repos_url"] as String
                        var newUser = User(login : login, id : id, avatarURL : avatarURL, URL : URL, reposURL : reposURL)
                        users.append(newUser)
                    }
                }
                return users
            }
        }
        return nil
    }
}
