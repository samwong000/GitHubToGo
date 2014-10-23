//
//  RootViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 23/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // This is called whenever during all navigation operations
        // Only return a custom animator for two view controller types
        if let rootViewController = fromVC as? UserViewController {
            if let detailViewControl = toVC as? UserDetailViewController {
                let animator = ShowImageAnimator()
                animator.origin = rootViewController.origin
                
                return animator
            }
        } else if let userDetailViewController = fromVC as? UserDetailViewController {
            let animator = HideImageAnimator()
            animator.origin = userDetailViewController.reverseOrigin
            
            return animator
        }
        
        // All other types use default transition
        return nil
    }
    
    
}