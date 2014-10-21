//
//  NetworkController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import Foundation

class NetworkController {
    
    class var controller : NetworkController {
    struct Static {
        static var onceToken : dispatch_once_t = 0  
        static var instance : NetworkController? = nil
        } 
        dispatch_once(&Static.onceToken) {
            Static.instance = NetworkController()
        }
        return Static.instance!
    }
    
    func fetchRepoInfo(git : Repo?, completionHandler : (errorDescription : String?, repo : [Repo]?) -> (Void) ) {
        let url = NSURL(string: "http://localhost:3000")

        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    //successful
                    let repoInfo = Repo.parseJSONDataIntoRepo(data)
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler (errorDescription : nil, repo : repoInfo)
                    })
//                    for header in httpResponse.allHeaderFields {
//                        println(header)
//                    }
//                    let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    println("responseString: \(responseString)")
                default:
                    println("bad response? \(httpResponse.statusCode)")
                }
            }
        })
        dataTask.resume()
    }
}