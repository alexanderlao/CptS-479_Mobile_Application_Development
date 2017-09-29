//
//  ViewController.swift
//  Joker
//
//  Created by Alexander Lao on 1/12/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate
{
    @IBOutlet weak var jokeNumber: UILabel!
    @IBOutlet weak var lineOne: UILabel!
    @IBOutlet weak var lineTwo: UILabel!
    @IBOutlet weak var lineThree: UILabel!
    @IBOutlet weak var answerLine: UILabel!
    
    @IBOutlet weak var oneStarImage: UIImageView!
    @IBOutlet weak var twoStarImage: UIImageView!
    @IBOutlet weak var threeStarImage: UIImageView!
    @IBOutlet weak var fourStarImage: UIImageView!
    @IBOutlet weak var fiveStarImage: UIImageView!
    
    // the array to hold all the jokes
    var jokes = [Joke]()
    var jokeIndex = 0
    
    func initializeJokes()
    {
        // create some jokes
        let jokeOne = Joke(firstLine: "How many programmers", secondLine: "does it take to",
                           thirdLine: "change a lightbulb?", answerLine: "Zero. That's a hardware problem.")
        
        let jokeTwo = Joke(firstLine: "How do you", secondLine: "find Will Smith",
                           thirdLine: "in the snow?", answerLine: "You look for the fresh prints.")
        
        let jokeThree = Joke(firstLine: "What did the", secondLine: "pirate say when",
                             thirdLine: "he turned 80?", answerLine: "Aye Matey!")
        
        // append the jokes to the array
        self.jokes.append(jokeOne)
        self.jokes.append(jokeTwo)
        self.jokes.append(jokeThree)
    }
    
    func chooseJoke()
    {
        // update the labels
        jokeNumber.text = "Joke #\(jokeIndex + 1)"
        lineOne.text = jokes[jokeIndex].firstLine
        lineTwo.text = jokes[jokeIndex].secondLine
        lineThree.text = jokes[jokeIndex].thirdLine
        answerLine.text = jokes[jokeIndex].answerLine
        
        // update the star rating
        displayStars()
    }
    
    @IBAction func swipeDetected (recognizer: UISwipeGestureRecognizer)
    {
        // retrieve the direction of the swipe
        let swipeDirection = recognizer.direction
        
        if (swipeDirection == .left)
        {
            // if the user swiped to the left on the last joke
            if (jokeIndex == jokes.count - 1)
            {
                // reset to the first joke
                jokeIndex = 0
            }
            else
            {
                // otherwise increment to the next joke
                jokeIndex += 1
            }
        }
        else if (swipeDirection == .right)
        {
            // if the user swiped to the right on the first joke
            if (jokeIndex == 0)
            {
                // move to the last joke
                jokeIndex = jokes.count - 1
            }
            else
            {
                // otherwise decrement to the previous joke
                jokeIndex -= 1
            }
        }
        
        // display the joke
        chooseJoke()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize the jokes and
        // choose the first joke to display
        initializeJokes()
        chooseJoke()
        
        // =========================================
        
        let tapOneStarGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(handleOneStarTap))
        tapOneStarGestureRecognizer.delegate = self
        self.oneStarImage.addGestureRecognizer(tapOneStarGestureRecognizer)
        
        // =========================================
        
        let tapTwoStarGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(handleTwoStarTap))
        tapTwoStarGestureRecognizer.delegate = self
        self.twoStarImage.addGestureRecognizer(tapTwoStarGestureRecognizer)
        
        // =========================================
        
        let tapThreeStarGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                   action: #selector(handleThreeStarTap))
        tapThreeStarGestureRecognizer.delegate = self
        self.threeStarImage.addGestureRecognizer(tapThreeStarGestureRecognizer)
        
        // =========================================
        
        let tapFourStarGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(handleFourStarTap))
        tapFourStarGestureRecognizer.delegate = self
        self.fourStarImage.addGestureRecognizer(tapFourStarGestureRecognizer)
        
        // =========================================
        
        let tapFiveStarGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector(handleFiveStarTap))
        tapFiveStarGestureRecognizer.delegate = self
        self.fiveStarImage.addGestureRecognizer(tapFiveStarGestureRecognizer)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleOneStarTap (recognizer: UITapGestureRecognizer)
    {
        print("One star tapped!")
        jokes[jokeIndex].rating = 1
        displayStars()
    }
    
    func handleTwoStarTap (recognizer: UITapGestureRecognizer)
    {
        print("Two stars tapped!")
        jokes[jokeIndex].rating = 2
        displayStars()
    }
    
    func handleThreeStarTap (recognizer: UITapGestureRecognizer)
    {
        print("Three stars tapped!")
        jokes[jokeIndex].rating = 3
        displayStars()
    }
    
    func handleFourStarTap (recognizer: UITapGestureRecognizer)
    {
        print("Four stars tapped!")
        jokes[jokeIndex].rating = 4
        displayStars()
    }
    
    func handleFiveStarTap (recognizer: UITapGestureRecognizer)
    {
        print("Five stars tapped!")
        jokes[jokeIndex].rating = 5
        displayStars()
    }
    
    func displayStars ()
    {
        if (jokes[jokeIndex].rating == 1)
        {
            // set the images of the stars to display a rating of one
            oneStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            twoStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            threeStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fourStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fiveStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
        }
        else if (jokes[jokeIndex].rating == 2)
        {
            // set the images of the stars to display a rating of two
            oneStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            twoStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            threeStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fourStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fiveStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
        }
        else if (jokes[jokeIndex].rating == 3)
        {
            // set the images of the stars to display a rating of three
            oneStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            twoStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            threeStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            fourStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fiveStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
        }
        else if (jokes[jokeIndex].rating == 4)
        {
            // set the images of the stars to display a rating of four
            oneStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            twoStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            threeStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            fourStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            fiveStarImage.image = #imageLiteral(resourceName: "greyStar.gif")

        }
        else if (jokes[jokeIndex].rating == 5)
        {
            // set the images of the stars to display a rating of five
            oneStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            twoStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            threeStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            fourStarImage.image = #imageLiteral(resourceName: "goldStar.png")
            fiveStarImage.image = #imageLiteral(resourceName: "goldStar.png")
        }
        else
        {
            // anything else, make all the stars grey
            oneStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            twoStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            threeStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fourStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
            fiveStarImage.image = #imageLiteral(resourceName: "greyStar.gif")
        }
    }
}

