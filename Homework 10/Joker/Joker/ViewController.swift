//
//  ViewController.swift
//  Joker
//
//  Created by Alexander Lao on 1/12/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit
import CoreData

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
    var jokes: JokeArray = JokeArray()
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
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
        self.jokes.jokes.append(jokeOne)
        self.jokes.jokes.append(jokeTwo)
        self.jokes.jokes.append(jokeThree)
    }
    
    func chooseJoke()
    {
        if (!jokes.jokes.isEmpty)
        {
            // generate a random number
            let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.jokes.count)))
        
            lineOne.text = jokes.jokes[randomJokeIndex].firstLine
            lineTwo.text = jokes.jokes[randomJokeIndex].secondLine
            lineThree.text = jokes.jokes[randomJokeIndex].thirdLine
            answerLine.text = jokes.jokes[randomJokeIndex].answerLine
        }
        // the jokes array is empty
        else
        {
            // clear all labels
            lineOne.text = "There are no jokes left!"
            lineTwo.text = ""
            lineThree.text = ""
            answerLine.text = ""
        }
    }
    
    // segue from the first view to the table view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "toTableView")
        {
            let tableVC = segue.destination as! TableViewController
            
            // pass the joke array from this view to the table view
            tableVC.tableJokes = jokes
        }
    }
    
    // unwind segue
    @IBAction func unwindFromSecondView (sender: UIStoryboardSegue)
    {
        let secondViewController = sender.source as! AddJokeViewController
        
        // retrieve the newJoke from the second view controller
        let newJoke = secondViewController.newJoke
        
        // add the newJoke to the joke array
        self.jokes.jokes.append(newJoke)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize the jokes and
        // choose the first joke to display
        initializeJokes()
        chooseJoke()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

