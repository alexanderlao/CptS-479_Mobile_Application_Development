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
    // variable to receive the number of jokes
    // from the first view
    var numberOfJokes: Int = 0
    
    // joke variable to hold the new joke
    var newJoke: Joke = Joke()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineOneTextField: UITextField!
    @IBOutlet weak var lineTwoTextField: UITextField!
    @IBOutlet weak var lineThreeTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: UIButton)
    {
        // dismiss the Add Joke View, does not invoke the unwind segue
        dismiss(animated: true, completion: nil)
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
