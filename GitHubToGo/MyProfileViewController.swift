//
//  MyProfileViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 24/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user : User?
    var repo = [Repo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkController.controller.oAuthToken != nil {
            //this improve the performance
            dispatch_after(1, dispatch_get_main_queue(), {
                NetworkController.controller.fetchAuthenticatedUserProfile({ (errorDescription, user) -> (Void) in
                    if errorDescription == nil {
                        self.user = user
                        
                        //fetch user image
                        NetworkController.controller.fetchImage(self.user!.avatarURL, completionHandler: { (image) -> (Void) in
                            self.imageView.image = image
                        })
                        self.fullNameLabel.text = self.user?.name
                        self.loginLabel.text = self.user?.login
                        
//                        //fetch user repos
//                        NetworkController.controller.fetchAuthenticatedUserRepos({ (errorDescription, repo) -> (Void) in
//                            if errorDescription != nil {
//                                println(errorDescription)
//                            } else {
//                                self.repo = repo!
//                                //this is an async process so must reload the tableview
//                                self.tableView.reloadData()
//                            }
//                        })
                        
                    
                    } else {
                        println(errorDescription)
                    }
                })
            })
        }

        self.tableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
        
        cell.fullNameLabel.text = self.repo[indexPath.row].fullName
        return cell
    }

}
