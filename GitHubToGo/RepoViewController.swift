//
//  ViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var repo = [Repo]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkController.controller.fetchRepoInfo(nil, completionHandler: { (errorDescription, repo) -> (Void) in
            if errorDescription != nil {
                //alert user the error
            } else {
                self.repo = repo!
                //this is an async process, must reload the tableview
                self.tableView.reloadData()
            }
        })
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
        
        cell.fullNameLabel.text = self.repo[indexPath.row].name
        return cell
    }
    
}

