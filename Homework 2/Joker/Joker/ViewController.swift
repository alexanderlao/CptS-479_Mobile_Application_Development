//
//  ViewController.swift
//  Joker
//
//  Created by Alexander Lao on 1/12/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBAction func answerTapped(_ sender: UIButton)
    {
        // if the answer is hidden
        if (answerLine.isHidden)
        {
            // change the button to display "New Joke"
            answerOutlet.setTitle("New Joke", for: .normal)
        }
        // if the answer is visible
        else
        {
            // choose a new joke
            chooseJoke()
            
            // change the button to display "Answer"
            answerOutlet.setTitle("Answer", for: .normal)
        }
        
        // if the answer was hidden, display it
        // or if the answer was visible, hide it
        answerLine.isHidden = !answerLine.isHidden
    }

    @IBOutlet weak var lineOne: UILabel!
    @IBOutlet weak var lineTwo: UILabel!
    @IBOutlet weak var lineThree: UILabel!
    @IBOutlet weak var answerLine: UILabel!
    @IBOutlet weak var answerOutlet: UIButton!
    
    // the array to hold all the jokes
    var jokes = [Joke]()
    
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
        // generate a random number
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.count)))
        
        lineOne.text = jokes[randomJokeIndex].firstLine
        lineTwo.text = jokes[randomJokeIndex].secondLine
        lineThree.text = jokes[randomJokeIndex].thirdLine
        answerLine.text = jokes[randomJokeIndex].answerLine
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize the jokes and
        // choose the first joke to display
        initializeJokes()
        chooseJoke()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

