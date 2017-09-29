//
//  AddJokeViewController.swift
//  Joker
//
//  Created by Alexander Lao on 2/5/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class AddJokeViewController: UIViewController, UITextFieldDelegate
{
    // lets the segue from the table know if the new joke is ready
    var newJokeReady: Bool = false
    
    // variable to receive the number of jokes
    // from the table view
    var numberOfJokes: Int = 0
    
    // joke variable to hold the new joke
    var newJoke: Joke = Joke()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineOneTextField: UITextField!
    @IBOutlet weak var lineTwoTextField: UITextField!
    @IBOutlet weak var lineThreeTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    // the save button was pressed
    @IBAction func savePressed(_ sender: UIBarButtonItem)
    {
        // update any changes in the text field
        self.newJoke.firstLine = self.lineOneTextField.text!
        self.newJoke.secondLine = self.lineTwoTextField.text!
        self.newJoke.thirdLine = self.lineThreeTextField.text!
        self.newJoke.answerLine = self.answerTextField.text!
        
        self.newJokeReady = true
        performSegue(withIdentifier: "unwindFromAddEntry", sender: nil)
    }
    
    // the cancel button was pressed
    @IBAction func cancelPressed(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "unwindFromAddEntry", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // hide the keyboard
        self.view.endEditing (true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // update the newJoke's fields to its respective textField
        self.newJoke.firstLine = lineOneTextField.text!
        self.newJoke.secondLine = lineTwoTextField.text!
        self.newJoke.thirdLine = lineThreeTextField.text!
        self.newJoke.answerLine = answerTextField.text!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set each of the text field's delegates to self
        self.lineOneTextField.delegate = self
        self.lineTwoTextField.delegate = self
        self.lineThreeTextField.delegate = self
        self.answerTextField.delegate = self
        
        // set the title label to the correct number oj jokes
        titleLabel.text = "Enter New Joke #\(numberOfJokes)"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
