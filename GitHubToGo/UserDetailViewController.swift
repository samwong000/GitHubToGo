//
//  UserDetailViewController.swift
//  GitHubToGo
//
//  Created by Sam Wong on 22/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage?
    var reverseOrigin : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Single Image"
        self.imageView.image = image
    }

    

}
