//
//  Comment.swift
//  Commenter
//
//  Created by Alexander Lao on 1/30/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import Foundation

class Comment
{
    var comment: String
    var date: Date
    
    init (newComment: String)
    {
        // initialize the comment member to a 
        // passed-in String and the date member
        // to the current date
        self.comment = newComment
        self.date = Date ()
    }
}
