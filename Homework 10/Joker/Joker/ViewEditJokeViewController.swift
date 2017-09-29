//
//  ViewEditJokeViewController.swift
//  Joker
//
//  Created by Alexander Lao on 4/2/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewEditJokeViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var editJokeLabel: UILabel!
    @IBOutlet weak var lineOneTextField: UITextField!
    @IBOutlet weak var lineTwoTextField: UITextField!
    @IBOutlet weak var lineThreeTextField: UITextField!
    @IBOutlet weak var answerLineTextField: UITextField!
    
    var editNumber: Int!
    var firstLineText: String!
    var secondLineText: String!
    var thirdLineText: String!
    var answerLineText: String!
    
    // joke variable to hold the new joke
    var newJoke: Joke = Joke()
    
    // lets the segue from the table know if the new joke is ready
    var newJokeReady: Bool = false
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem)
    {
        // update any changes in the text field
        self.newJoke.firstLine = self.lineOneTextField.text!
        self.newJoke.secondLine = self.lineTwoTextField.text!
        self.newJoke.thirdLine = self.lineThreeTextField.text!
        self.newJoke.answerLine = self.answerLineTextField.text!
        
        self.newJokeReady = true
        performSegue(withIdentifier: "unwindFromEditEntry", sender: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "unwindFromEditEntry", sender: nil)
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
        self.newJoke.firstLine = self.lineOneTextField.text!
        self.newJoke.secondLine = self.lineTwoTextField.text!
        self.newJoke.thirdLine = self.lineThreeTextField.text!
        self.newJoke.answerLine = self.answerLineTextField.text!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set each of the text field's delegates to self
        self.lineOneTextField.delegate = self
        self.lineTwoTextField.delegate = self
        self.lineThreeTextField.delegate = self
        self.answerLineTextField.delegate = self
        
        self.editJokeLabel.text = "Edit Joke #\(editNumber!)"
        self.lineOneTextField.text = firstLineText
        self.lineTwoTextField.text = secondLineText
        self.lineThreeTextField.text = thirdLineText
        self.answerLineTextField.text = answerLineText
    }

    override func didReceiveMemoryWarning() {
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
