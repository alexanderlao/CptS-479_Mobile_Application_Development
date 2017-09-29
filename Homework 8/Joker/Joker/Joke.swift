//
//  Joke.swift
//  Joker
//
//  Created by Alexander Lao on 1/24/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import Foundation

class Joke
{
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    var rating: Int
    
    init (firstLine: String = "", secondLine: String = "",
          thirdLine: String = "", answerLine: String = "")
    {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.thirdLine = thirdLine
        self.answerLine = answerLine
        self.rating = 0
    }
}
