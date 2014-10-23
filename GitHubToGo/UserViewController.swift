//
//  UserViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 22/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var origin : CGRect?
    var users = [User]()
    var images = [UIImage]()
    var flowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.flowLayout = self.collectionView.collectionViewLayout as UICollectionViewFlowLayout
        
        if NetworkController.controller.oAuthToken == nil {
            //this improve the performance
            dispatch_after(1, dispatch_get_main_queue(), {
                NetworkController.controller.requestOAuthAccess()
            })
        }

        self.searchBar.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell


//        
//        var currentTag = cell.tag + 1
//        cell.tag = currentTag
//        
//        let user = self.users[indexPath.row]
//        
//        if user.avatarImage != nil {
//            let cellForImage = self.collectionView.cellForItemAtIndexPath(indexPath) as UserCell?
//            if cell.tag == currentTag {
//                cellForImage?.imageView.image = user.avatarImage
//                cellForImage?.userName.text = user.login
//            }
//        } else {
//            NetworkController.controller.downloadUserImage(user, completionHandler: { (image) -> (Void) in
//                let cellForImage = self.collectionView.cellForItemAtIndexPath(indexPath) as UserCell?
//                
//                if cell.tag == currentTag {
//                    cellForImage?.imageView.image = image
//                }
//                
//            })
//        }
        
        var currentTag = cell.tag + 1
        cell.tag = currentTag
        let user = self.users[indexPath.row]
        
        NetworkController.controller.downloadUserImage(user, completionHandler: { (image) -> (Void) in
            let cellForImage = self.collectionView.cellForItemAtIndexPath(indexPath) as UserCell?
            
            if cell.tag == currentTag {
                cellForImage?.imageView.image = image
            }
            
        })

        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        let origin = self.view.convertRect(attributes!.frame, fromView : collectionView)
        self.origin = origin

        let user = self.users[indexPath.row] as User
        let image = user.avatarImage
        let storyboard = UIStoryboard(name : "Main", bundle : nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("UserDetailVC") as UserDetailViewController
        
        viewController.image = image
        viewController.reverseOrigin = self.origin!
    
        self.navigationController?.pushViewController(viewController, animated : true)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        println("Search Text is \(searchText)")
        
        //hide search bar
        searchBar.resignFirstResponder()

        NetworkController.controller.fetchUsers(searchText, completionHandler: { (errorDescription, users) -> (Void) in
            if errorDescription == nil {
                self.users = users!
                self.collectionView.reloadData()
            }
        })
    }
    
}
