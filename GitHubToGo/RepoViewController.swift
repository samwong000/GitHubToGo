//
//  ViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 20/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var repo = [Repo]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkController.controller.oAuthToken == nil {
            //this improve the performance
            dispatch_after(1, dispatch_get_main_queue(), {
                NetworkController.controller.requestOAuthAccess()
            })
        }
        
        self.searchBar.delegate = self
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("RepoDetailVC") as RepoDetailViewController
        let repo = self.repo[indexPath.row]
        destinationVC.repo = repo
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        
        //hide search bar
        searchBar.resignFirstResponder()
        
        println("Search Text is \(searchText)")
        
        NetworkController.controller.fetchRepos(searchText, completionHandler: { (errorDescription, repo) -> (Void) in
            if errorDescription != nil {
                println("Error! searchBarSearchButtonClicked:fetchRepos \(errorDescription) ")
            } else {
                self.repo = repo!
                //this is an async process so must reload the tableview
                self.tableView.reloadData()
            }
        })
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println("searchBar:shouldChangeTextInRange text = \(text)")
        println(text.validate())
        
        return text.validate()
        
    }
    
}

