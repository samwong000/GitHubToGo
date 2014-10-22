//
//  NetworkController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class NetworkController {
    
    let clientID = "client_id=8f6ae63f908ae680c13d"
    let clientSecret = "client_secret=d98ecac852a13f8243035541daee36ef6e724763"
    let githubOAuthURL = "https://github.com/login/oauth/authorize"
    let scope = "scope=user,repo"
    let redirectURL = "redirect_uri=githubtogo://test"
    
    let tokenName : String = "MyToken"
    var oAuthToken : String?
    
    var authenticatedSession : NSURLSession?
    
    // get from https://developer.github.com/v3/oauth/
    let githubPostURL = "https://github.com/login/oauth/access_token"
    

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

    init() {
        if self.oAuthToken == nil {
            if let tokenValue = NSUserDefaults.standardUserDefaults().valueForKey(self.tokenName) as? String {
                self.oAuthToken = tokenValue
                var sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
                var HTTPAdditionalHeaders =  ["Authorization" : "token \(self.oAuthToken!)"]
                sessionConfiguration.HTTPAdditionalHeaders = HTTPAdditionalHeaders
                self.authenticatedSession = NSURLSession(configuration: sessionConfiguration)
            }
        }
    }
    
    //Refer to https://developer.github.com/v3/oauth/ for all steps

    //step1: Redirect users to request GitHub access
    func requestOAuthAccess() {
        let url = githubOAuthURL + "?" + clientID + "&" + redirectURL + "&" + scope
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func handleOAuthURL(callbackURL : NSURL) {
        //pase through the url that is given to us by GitHub
        let query = callbackURL.query
        let components = query?.componentsSeparatedByString("code=")
        //get the last item in the components array
        let code = components?.last
    
        //construct query string for the POST call
        let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
        var request = NSMutableURLRequest(URL: NSURL(string: githubPostURL)!)
        request.HTTPMethod = "POST"
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding,
            allowLossyConversion: true)
        let length = postData!.length
        //question: where to find the HTTPHeaderField?
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
    
        let dataTask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println("dataTaskWithRequest Error!")
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)

                        if tokenResponse != nil {
                            
                            //Recreate a NSURLSession with a NSURLSessionConfiguration with the Authorization Header Field matched up with our oath toke
                            let tokenResponseArray = tokenResponse?.componentsSeparatedByString("access_token=")
                            let accessTokenArray = tokenResponseArray?[1].componentsSeparatedByString("&")
                            
                            self.oAuthToken = accessTokenArray?.first as? String
                            
                            NSUserDefaults.standardUserDefaults().setObject(self.oAuthToken!, forKey: self.tokenName)
                            NSUserDefaults.standardUserDefaults().synchronize()

                            println("accessToken = \(self.oAuthToken!)")
                            
                            var sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
                            var HTTPAdditionalHeaders =  ["Authorization" : "token \(self.oAuthToken!)"]
                            sessionConfiguration.HTTPAdditionalHeaders = HTTPAdditionalHeaders
                            self.authenticatedSession = NSURLSession(configuration: sessionConfiguration)
                        }
                        
                    default:
                        println("default case on status code")
                    }
                }
            }
            
        }).resume() //must quote resume() to make it work
    }
    
    func fetchRepoInfo(repo : Repo?, completionHandler : (errorDescription : String?, repo : [Repo]?) -> (Void) ) {
        //let url = NSURL(string: "http://localhost:3000")

//        let url = NSURL(string: "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc")

        let url = NSURL(string: "https://api.github.com/search/repositories?q=\(repo?.name)")
        
        if authenticatedSession != nil {
            let dataTask = authenticatedSession!.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
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
    
    func fetchRepoInfoWithSearchTerm(searchText : NSString, completionHandler : (errorDescription : String?, repo : [Repo]?) -> (Void) ) {
        //let url = NSURL(string: "http://localhost:3000")
//        let formattedSearchTerm = searchText.stringByReplacingOccurencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        //        let url = NSURL(string: "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc")
        
        let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchText)")
        
        if authenticatedSession != nil {
            let dataTask = authenticatedSession!.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
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

    
}