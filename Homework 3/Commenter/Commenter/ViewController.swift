//
//  ViewController.swift
//  Commenter
//
//  Created by Alexander Lao on 1/30/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    // declare the Comment array to hold all of the comments
    var comments = [Comment]();
    
    // outlet to the text field
    @IBOutlet weak var commentBox: UITextField!
    
    // the "Add" button was pressed
    @IBAction func addPressed(_ sender: UIButton)
    {
        // check if there's text in the text field
        if (commentBox.text != "")
        {
            // create the new comment with the content of the commentBox
            let newComment = Comment (newComment: commentBox.text!)
            
            // add the newComment to the commentArray
            self.comments.append (newComment)
            
            // clear the text field
            commentBox.text = ""
        }
    }
    
    // the "Print All" button was pressed
    @IBAction func printAllPressed(_ sender: UIButton)
    {
        print ("========== Print All Pressed ==========")
        
        // loop through the comments array
        for comment in comments
        {
            // print out each comment
            print ("\(comment.date): \(comment.comment)")
        }
    }
    
    // Asks the delegate if the text field should process the pressing of the return button
    // https://developer.apple.com/reference/uikit/uitextfielddelegate/1619603-textfieldshouldreturn?language=objc
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // hide the keyboard
        self.view.endEditing (true)
        return false
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentBox.delegate = self;
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

