//
//  RepoDetailViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 23/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit
import WebKit

class RepoDetailViewController: UIViewController {
    
    var repo : Repo?
    let webView = WKWebView()

    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var url = NSURL(string:repo!.htmlURL)
        var req = NSURLRequest(URL:url!)
        self.webView.loadRequest(req)
        
    }


}
