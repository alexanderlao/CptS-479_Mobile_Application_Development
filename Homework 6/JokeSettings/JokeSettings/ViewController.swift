//
//  ViewController.swift
//  JokeSettings
//
//  Created by Alexander Lao on 2/18/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var shuffleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restrictContentLabel: UILabel!
    
    func updateText ()
    {
        // setting the "Name:" label based on the value from the global settings
        if (UserDefaults.standard.object(forKey: "name_preference") != nil)
        {
            // updating the name label from the global settings
            let globalName = UserDefaults.standard.string(forKey: "name_preference")!
            nameLabel.text = "Name: \(globalName)"
        }
        else
        {
            // default is an empty string
            nameLabel.text = "Name:"
        }
        
        // setting the "Restrict Content:" label based on the value from the global settings
        if (UserDefaults.standard.object(forKey: "enabled_preference") != nil)
        {
            // updating the restrict content label from the global settings
            let globalRestrict = UserDefaults.standard.bool(forKey: "enabled_preference")
            
            if (globalRestrict)
            {
                restrictContentLabel.text = "Restrict Content: Yes"
            }
            else
            {
                restrictContentLabel.text = "Restrict Content: No"
            }
        }
        else
        {
            // default is on
            restrictContentLabel.text = "Restrict Content: Yes"
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateText()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // setting the "Sort by:" label based on the value of the segmented control
        if (UserDefaults.standard.object(forKey: "segmented_control") != nil)
        {
            let segmentedText = UserDefaults.standard.string(forKey: "segmented_control")!
            sortByLabel.text = "Sort by: \(segmentedText)"
        }
        else
        {
            // default is sort by rating
            sortByLabel.text = "Sort by: Rating"
        }
        
        // setting the "Shuffle:" label based on the value of the switch
        if (UserDefaults.standard.object(forKey: "switch") != nil)
        {
            let switchBool = UserDefaults.standard.bool(forKey: "switch")
            
            // switchBool is true if the switch is on
            if (switchBool)
            {
                shuffleLabel.text = "Shuffle: On"
            }
            else
            {
                // otherwise the shuffle is off
                shuffleLabel.text = "Shuffle: Off"
            }
        }
        else
        {
            // default is shuffle is on
            shuffleLabel.text = "Shuffle: On"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
