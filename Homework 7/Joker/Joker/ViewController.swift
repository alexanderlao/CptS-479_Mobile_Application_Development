//
//  ViewController.swift
//  Joker
//
//  Created by Alexander Lao on 1/12/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController
{
    @IBOutlet weak var messageLabel: UILabel!
    
    var notificationsOkay = false
    
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
    
    @IBAction func scheduleNotification(_ sender: UIButton)
    {
        if (notificationsOkay)
        {
            messageLabel.text = "Joke scheduled!"
            scheduleNotification1()
        }
        else
        {
            messageLabel.text = "Notifications are disabled!"
        }
    }
    
    // Call from applicationDidEnterForeground or before notification
    func checkIfNotificationsStillOkay()
    {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler:
            self.handleNotificationSettings)
    }
    
    func handleNotificationSettings (notificationSettings: UNNotificationSettings)
    {
        if ((notificationSettings.alertSetting == .enabled) &&
            (notificationSettings.badgeSetting == .enabled) &&
            (notificationSettings.soundSetting == .enabled))
        {
            self.notificationsOkay = true
            print ("Yes!")
        }
        else
        {
            self.notificationsOkay = false
            print ("No!")
        }
    }
    
    func scheduleNotification1()
    {
        // generate a random number
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.count)))
        
        let content = UNMutableNotificationContent()
        content.title = "Here's a joke! Tap for the answer!"
        content.body = jokes[randomJokeIndex].firstLine + " " + jokes[randomJokeIndex].secondLine +
                       " " + jokes[randomJokeIndex].thirdLine
        content.userInfo["Answer"] = jokes[randomJokeIndex].answerLine
        
        // Configure trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,
                                                        repeats: false)
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive",
                                            content: content, trigger: trigger)
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func handleNotification1 (_ response: UNNotificationResponse)
    {
        let message = response.notification.request.content.userInfo["Answer"] as! String
        print("handleNotification1")
        
        let alert = UIAlertController(title: "Answer",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default,
                                      handler: { (action) in
                                        // execute some code when this option is selected
                                        self.messageLabel.text = ""
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize the jokes and
        // choose the first joke to display
        initializeJokes()
        
        messageLabel.text = ""
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
