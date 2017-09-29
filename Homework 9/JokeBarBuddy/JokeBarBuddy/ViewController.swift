//
//  ViewController.swift
//  JokeBarBuddy
//
//  Created by Alexander Lao on 3/26/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var firstJokeLine: UILabel!
    @IBOutlet weak var secondJokeLine: UILabel!
    @IBOutlet weak var thirdJokeLine: UILabel!
    @IBOutlet weak var answerLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getJokeTapped(_ sender: Any)
    {
        // communicate with the PHP script
        let url = URL(string: "http://www.eecs.wsu.edu/~holder/courses/MAD/hw9/getjoke.php")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: handleJokeResponse)
        dataTask.resume()
    }
    
    func handleJokeResponse (data: Data?, response: URLResponse?, error: Error?)
    {
        if (error != nil)
        {
            print("error: \(error!.localizedDescription)")
        }
        else
        {
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode != 200
            {
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                print("HTTP \(statusCode) error: \(msg)")
            }
            else
            {
                // respsonse okay, do something with data
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!,
                                                                   options: [])
                {
                    // retrieve the joke is JSON format and break it down
                    let jsonDict = jsonObj as! [String: AnyObject]
                    let jokeJSON = jsonDict["joke"] as! [String: AnyObject]
                    let lineOne = jokeJSON["line1"] as! String
                    let lineTwo = jokeJSON["line2"] as! String
                    let lineThree = jokeJSON["line3"] as! String
                    let answerJSON = jokeJSON["answer"] as! String
                    
                    // use this to run on the main thread
                    DispatchQueue.main.async
                    {
                            // set the text labels to the values of the JSON joke
                            self.firstJokeLine.text = lineOne
                            self.secondJokeLine.text = lineTwo
                            self.thirdJokeLine.text = lineThree
                            self.answerLine.text = answerJSON
                        
                            // make the text labels visible
                            self.firstJokeLine.isHidden = false
                            self.secondJokeLine.isHidden = false
                            self.thirdJokeLine.isHidden = false
                            self.answerLine.isHidden = false
                    }
                    
                }
                else
                {
                    print("error: invalid JSON data")
                }
                
            }
        }
    }
}

