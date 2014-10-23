//
//  UserCell.swift
//  GitHubToGo
//
//  Created by Sam Wong on 22/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "")
    }
}
