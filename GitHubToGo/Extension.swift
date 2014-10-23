//
//  Extension.swift
//  GitHubToGo
//
//  Created by Sam Wong on 23/10/2014.
//  Copyright (c) 2014 21. All rights reserved.
//

import Foundation

extension String {
    func validate() -> Bool {
        let regex = NSRegularExpression(pattern : "[^0-9a-zA-Z \n]", options : nil, error : nil)
        
        let match = regex?.numberOfMatchesInString(self, options: nil, range: NSRange(location:0, length: countElements(self)))
        
        if match > 0 {
            return false
        }
        
        return true
    }
}