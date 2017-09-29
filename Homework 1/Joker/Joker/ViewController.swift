//
//  ViewController.swift
//  Joker
//
//  Created by Alexander Lao on 1/12/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func answerTapped(_ sender: UIButton)
    {
        if (punchline.isHidden)
        {
            answerOutlet.setTitle("Hide", for: .normal)
        }
        else
        {
            answerOutlet.setTitle("Answer", for: .normal)
        }
        
        punchline.isHidden = !punchline.isHidden
    }
    
    @IBOutlet weak var answerOutlet: UIButton!
    @IBOutlet weak var punchline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

