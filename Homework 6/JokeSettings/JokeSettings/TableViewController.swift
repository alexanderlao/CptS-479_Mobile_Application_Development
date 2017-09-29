//
//  TableViewController.swift
//  JokeSettings
//
//  Created by Alexander Lao on 2/18/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{
    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var shuffleLabel: UILabel!
    
    @IBOutlet weak var sortBySegmentedControl: UISegmentedControl!
    @IBOutlet weak var shuffleSwitch: UISwitch!
    
    // the action function for the segmented control
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
            case 0:
                sortByLabel.text = "Sort by: Rating"
                UserDefaults.standard.set("Rating", forKey: "segmented_control")

            case 1:
                sortByLabel.text = "Sort by: Views"
                UserDefaults.standard.set("Views", forKey: "segmented_control")

            default:
                break
        }
    }
    
    // the action function for the switch
    @IBAction func switchChanged(_ sender: UISwitch)
    {
        if (sender.isOn)
        {
            shuffleLabel.text = "Shuffle: On"
            UserDefaults.standard.set(true, forKey: "switch")
        }
        else
        {
            shuffleLabel.text = "Shuffle: Off"
            UserDefaults.standard.set(false, forKey: "switch")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // setting the "Sort by:" label based on the value of the segmented control
        if (UserDefaults.standard.object(forKey: "segmented_control") != nil)
        {
            // updating the segmented control label
            let segmentedText = UserDefaults.standard.string(forKey: "segmented_control")!
            sortByLabel.text = "Sort by: \(segmentedText)"
            
            // updating the UISegmentedControl
            if (segmentedText == "Rating")
            {
                // update the segmented control for the rating state
                sortBySegmentedControl.selectedSegmentIndex = 0
            }
            else
            {
                // otherwise update the segmented control for the views state
                sortBySegmentedControl.selectedSegmentIndex = 1
            }
        }
        // default is sort by rating
        else
        {
            // update the label and segmented control to display the rating's setting
            sortByLabel.text = "Sort by: Rating"
            sortBySegmentedControl.selectedSegmentIndex = 0
        }
        
        // setting the "Shuffle:" label based on the value of the switch
        if (UserDefaults.standard.object(forKey: "switch") != nil)
        {
            let switchBool = UserDefaults.standard.bool(forKey: "switch")
            
            // switchBool is true if the switch is on
            if (switchBool)
            {
                // update the label and switch to show they're on
                shuffleLabel.text = "Shuffle: On"
                shuffleSwitch.setOn(true, animated: true)
            }
            // otherwise the shuffle is off
            else
            {
                // update the label and switch to show they're off
                shuffleLabel.text = "Shuffle: Off"
                shuffleSwitch.setOn(false, animated: false)
            }
        }
        // default is shuffle is on
        else
        {
            // update the label and switch to show they're on
            shuffleLabel.text = "Shuffle: On"
            shuffleSwitch.setOn(true, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
