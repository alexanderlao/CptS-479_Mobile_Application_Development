//
//  JokeFuViewController.swift
//  JokeBarBuddy
//
//  Created by Alexander Lao on 3/27/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class JokeFuViewController: UIViewController, UIGestureRecognizerDelegate
{
    var startPoint: CGPoint!
    
    var startTouched = false
    var startingY = 0
    var straightLine = true
    var finishTouched = false
    var dotView: UIView!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var passFailImage: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBAction func tryAgainTapped(_ sender: UIButton)
    {
        // reset the test flags
        self.startTouched = false
        self.straightLine = true        // the straightLine flag defaults to true because of an "innocent until proven guilty" approach
        self.finishTouched = false
        
        // hide the image and try again button
        self.passFailImage.isHidden = true
        self.tryAgainButton.isHidden = true
        
        // remove the dots from the view
        self.resetView()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // hide the pass/fail image and the try again button
        self.passFailImage.isHidden = true
        self.tryAgainButton.isHidden = true
        
        // set up the pan gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print ("touchesBegan")
        startPoint = touches.first?.location(in: self.view)
    }

    func handlePan (recognizer: UIPanGestureRecognizer)
    {
        let point = recognizer.location(in: self.view)
        
        dotView = UIView(frame: CGRect(x: point.x, y: point.y,
                                       width: 5.0, height: 5.0))
        dotView.tag = 100   // tag is set to 100 so we can remove them later
        dotView.backgroundColor = UIColor.blue
        self.view.addSubview(dotView)
        
        let xi = Int(point.x)
        let yi = Int(point.y)
        
        // when the pan begins
        if (recognizer.state == .began)
        {
            // check if the pan started at the start label
            if (self.startLabel.frame.contains(startPoint))
            {
                // set the startTouched flag to true
                // and keep a reference to the startingY position
                print ("start label touched")
                self.startTouched = true
                self.startingY = yi
            }
        }
        // when the pan moves
        if (recognizer.state == .changed)
        {
            // check if movement is relatively close to the startingY position
            // as soon as the line isn't straight set the straightLine flag to false
            // "innocent until proven guilty" approach
            if (startingY < yi - 10 || startingY > yi + 10)
            {
                print ("not straight")
                self.straightLine = false
            }
        }
        // when the pan ends
        if (recognizer.state == .ended)
        {
            // retrieve the end point
            let endPoint = CGPoint(x: xi, y: yi)
            
            // check if the pan ended at the finish label
            if (self.finishLabel.frame.contains(endPoint))
            {
                // set the finishTouched flag to true
                print ("end label touched")
                self.finishTouched = true
            }
            
            // check the flags
            self.checkTest()
        }
    }
    
    func checkTest()
    {
        print ("checking test")
        
        // if all flags are true
        if (self.startTouched && self.straightLine && self.finishTouched)
        {
            // display the pass image
            self.passFailImage.image = #imageLiteral(resourceName: "passImage.png")
        }
        else
        {
            // otherwise display the fail image
            self.passFailImage.image = #imageLiteral(resourceName: "failImage.png")
        }
        
        // make the image and try again button visible
        self.passFailImage.isHidden = false
        self.tryAgainButton.isHidden = false
    }
    
    func resetView()
    {
        // retrieve all the subviews
        let subViews = self.view.subviews
        
        // loop through each view in the subviews
        for subview in subViews
        {
            // check for dotViews (dotViews have the tag 100)
            if subview.tag == 100
            {
                // remove each dotView
                subview.removeFromSuperview()
            }
        }
    }
}
