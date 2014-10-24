//
//  MyProfileViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 24/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkController.controller.oAuthToken != nil {
            //this improve the performance
            dispatch_after(1, dispatch_get_main_queue(), {
                NetworkController.controller.fetchAuthenticatedUserProfile({ (errorDescription, user) -> (Void) in
                    if errorDescription == nil {
                        self.user = user
                        
                        println(user)
                    } else {
                        println(errorDescription)
                    }
                })
            })
        }

        
    }


}
