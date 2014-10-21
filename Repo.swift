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

    init(fullName : String, id : Int, name : String) {
        self.id = id
        self.name = name
        self.fullName = fullName
    }
    
    class func parseJSONDataIntoRepo(rawJSONData : NSData) -> [Repo]? {
        var error : NSError?
        var repos = [Repo]()
        
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData (rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            if let itemsArray = JSONDictionary["items"] as? NSArray {
                for anyItem in itemsArray {
                    let fullName = anyItem ["full_name"] as String
                    let id = anyItem ["id"] as Int
                    let name = anyItem ["name"] as String
                    
                    var newRepo = Repo(fullName: fullName, id: id, name: name)
                    repos.append(newRepo)
                }
                
                return repos
            }
        }
        return nil
    }
}
