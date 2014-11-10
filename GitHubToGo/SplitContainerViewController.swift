//
//  SplitContainerViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class SplitContainerViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let splitVC = self.childViewControllers[0] as UISplitViewController
        splitVC.delegate = self
        
        if NetworkController.controller.oAuthToken == nil {
            //this improve the performance
            dispatch_after(1, dispatch_get_main_queue(), {
                NetworkController.controller.requestOAuthAccess()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        
        // true - show menu screen
        // false - show detail
        
        return true
    }



}
