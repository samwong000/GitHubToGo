//
//  Git.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class Repo {
    
//    var totalCount : Int
    
    var id : Int
    var name : String
    var fullName : String

    init(id : Int, name : String, fullName : String) {
        self.id = id
        self.name = name
        self.fullName = fullName
    }
    
    class func parseJSONDataIntoRepo(rawJSONData : NSData) -> [Repo]? {
        var error : NSError?
        var repos = [Repo]()
        
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData (rawJSONData, options: nil, error: &error) as? NSDictionary {
            if error != nil {
                println(error)
                return nil
            }
            
            if let itemsArray = JSONDictionary["items"] as? NSArray {
                for object in itemsArray {
                    //added NSDictionary check
                    if let item = object as? NSDictionary {
                        let fullName = item ["full_name"] as String
                        let id = item ["id"] as Int
                        let name = item ["name"] as String
                        
                        var newRepo = Repo(id: id, name: name, fullName: fullName)
                        repos.append(newRepo)
                    }
                }
                
                return repos
            }
        }
        return nil
    }
}
