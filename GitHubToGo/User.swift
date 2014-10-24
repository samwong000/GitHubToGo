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
    var reposURL : String?
    var avatarImage: UIImage!
    var hireable : Bool? = false
    var bio : String?
    var publicRepos : Int? = 0
    var privateRepos : Int? = 0

    
    init(login : String, id : Int, avatarURL : String, URL : String, reposURL : String?, hireable : Bool?, bio : String?, publicRepos : Int?, privateRepos : Int?) {
        self.login = login
        self.id = id
        self.avatarURL = avatarURL
        self.URL = URL
        self.reposURL = reposURL
        self.hireable = hireable
        self.bio = bio?
        self.publicRepos = publicRepos
        self.privateRepos = privateRepos
    }
    
    class func parseJSONDataIntoUsers(rawJSONData : NSData) -> [User]? {
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
                        let hireable = item["hireable"] as? Bool
                        let publicRepos = item["public_repos"] as? Int
                        let bio = item["bio"] as? String
                        let privateRepos = item["private_repos"] as? Int
                        
                        var newUser = User(login: login, id: id, avatarURL: avatarURL, URL: URL, reposURL: reposURL, hireable: hireable, bio: bio, publicRepos: publicRepos, privateRepos: privateRepos)
                        users.append(newUser)
                    }
                }
                return users
            }
        }
        return nil
    }
    
    class func parseJSONDataIntoUser(rawJSONData : NSData) -> User? {
        var error : NSError?
        
        if let item = NSJSONSerialization.JSONObjectWithData(rawJSONData, options : nil, error : &error) as? NSDictionary {
            if error != nil {
                println(error)
                return nil
            }
            
            let login = item["login"] as String
            let id = item["id"] as Int
            let avatarURL = item["avatar_url"] as String
            let URL = item["url"] as String
            let reposURL = item["repos_url"] as String
            let hireable = item["hireable"] as Bool
            let publicRepos = item["public_repos"] as Int
            let bio = item["bio"] as? String
            let privateRepos = item["owned_private_repos"] as Int
            
            var user = User(login: login, id: id, avatarURL: avatarURL, URL: URL, reposURL: reposURL, hireable: hireable, bio: bio, publicRepos: publicRepos, privateRepos: privateRepos)
            
            return user

        }
        return nil
    }
}
