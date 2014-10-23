//
//  ViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 22/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // this func gets triggered when user clicks on the row
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        // open main storyboard, click on the respective view controller -> inspector view -> set storyBoardID
//        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("SingleTweetVC") as TweetViewController
//        let tweet = self.tweets?[indexPath.row]
//        destinationVC.tweet = tweet
//        
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
////        let tweet = self.tweets?[indexPath.row]
////        cell.tweetLabel.text = tweet?.text
////        
////        if tweet?.profileImage != nil {
////            cell.tweetImageView.image = tweet?.profileImage
////        } else {
////            //make asyn call
////            NetworkController.controller.downloadUserImageForTweet(tweet!, completionHandler: { (image) -> (Void) in
////                let cellForImage = self.tableView.cellForRowAtIndexPath(indexPath) as TweetCell?
////                cellForImage?.tweetImageView.image = image
////            })
////        }
////        
////        return cell
//    }
//    
//    //infinite scrolling
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//
//    }
//    

}
