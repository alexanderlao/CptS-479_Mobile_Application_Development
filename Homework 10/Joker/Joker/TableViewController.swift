//
//  TableViewController.swift
//  Joker
//
//  Created by Alexander Lao on 2/11/17.
//  Copyright © 2017 Alexander Lao. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController
{
    // array of jokes
    var tableJokes: JokeArray = JokeArray()
    var selectedRow = 0
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (appDelegate.flag == true)
        {
            self.loadJokes()
            appDelegate.flag = false
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
        return tableJokes.jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        // display the first line
        cell.textLabel?.text = tableJokes.jokes[indexPath.row].firstLine

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "toEditView", sender: nil)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // delete the joke from the core data
            let deleteJoke = tableJokes.jokes[indexPath.row]
            let answerLine = deleteJoke.answerLine
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataJoke")
            fetchRequest.predicate = NSPredicate(format: "answerLine == %@", answerLine)
            var jokes: [NSManagedObject]!
            do
            {
                jokes = try self.managedObjectContext.fetch(fetchRequest)
            }
            catch
            {
                print("removeJokes error: \(error)")
            }
            for joke in jokes
            {
                self.managedObjectContext.delete(joke)
            }
            self.appDelegate.saveContext() // In AppDelegate.swift
            
            
            // Delete the row from the data source
            tableJokes.jokes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toAddEntry")
        {
            let addEntryVC = segue.destination as! AddJokeViewController
            
            // increment the numberOfJokes variable in the addEntry view
            // based on the number of jokes in the joke array
            addEntryVC.numberOfJokes = tableJokes.jokes.count + 1
        }
        
        if (segue.identifier == "toEditView")
        {
            let viewEditJokeVC = segue.destination as! ViewEditJokeViewController
            viewEditJokeVC.editNumber = self.selectedRow + 1
            viewEditJokeVC.firstLineText = tableJokes.jokes[selectedRow].firstLine
            viewEditJokeVC.secondLineText = tableJokes.jokes[selectedRow].secondLine
            viewEditJokeVC.thirdLineText = tableJokes.jokes[selectedRow].thirdLine
            viewEditJokeVC.answerLineText = tableJokes.jokes[selectedRow].answerLine
        }
        
    }
    
    @IBAction func unwindFromAddEntry (segue: UIStoryboardSegue)
    {
        let addVC = segue.source as! AddJokeViewController
        if (addVC.newJokeReady)
        {
            // add the joke to the table
            let newJokeFromAdd = addVC.newJoke
            tableJokes.jokes.append (newJokeFromAdd)
            self.tableView.reloadData()
            
            // add the joke to the core data
            let coreDataJoke = NSEntityDescription.insertNewObject(forEntityName: "DataJoke", into: self.managedObjectContext)
            coreDataJoke.setValue(newJokeFromAdd.firstLine, forKey: "firstLine")
            coreDataJoke.setValue(newJokeFromAdd.secondLine, forKey: "secondLine")
            coreDataJoke.setValue(newJokeFromAdd.thirdLine, forKey: "thirdLine")
            coreDataJoke.setValue(newJokeFromAdd.answerLine, forKey: "answerLine")
            self.appDelegate.saveContext() // In AppDelegate.swift
        }
    }
    
    @IBAction func unwindFromEditEntry (segue: UIStoryboardSegue)
    {
        let editVC = segue.source as! ViewEditJokeViewController
        if (editVC.newJokeReady)
        {
            // update the joke in the table
            let editedJoke = editVC.newJoke
            tableJokes.jokes[selectedRow].firstLine = editedJoke.firstLine
            tableJokes.jokes[selectedRow].secondLine = editedJoke.secondLine
            tableJokes.jokes[selectedRow].thirdLine = editedJoke.thirdLine
            tableJokes.jokes[selectedRow].answerLine = editedJoke.answerLine
            self.tableView.reloadData()
            
            // edit the joke in the core data
            let answerLine = editedJoke.answerLine
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataJoke")
            fetchRequest.predicate = NSPredicate(format: "answerLine == %@", answerLine)
            var jokes: [NSManagedObject]!
            do
            {
                jokes = try self.managedObjectContext.fetch(fetchRequest)
            }
            catch
            {
                print("editJokes error: \(error)")
            }
            for joke in jokes
            {
                joke.setValue(editedJoke.firstLine, forKey: "firstLine")
                joke.setValue(editedJoke.secondLine, forKey: "secondLine")
                joke.setValue(editedJoke.thirdLine, forKey: "thirdLine")
                joke.setValue(editedJoke.answerLine, forKey: "answerLine")
            }
            
            self.appDelegate.saveContext() // In AppDelegate.swift
        }
    }
    
    // load the jokes from the core data into the table
    func loadJokes()
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataJoke")
        var jokes: [NSManagedObject]!
        do
        {
            jokes = try self.managedObjectContext.fetch(fetchRequest)
        }
        catch
        {
            print("loadJokes error: \(error)")
        }
        print("Found \(jokes.count) jokes")
        for joke in jokes
        {
            let lineOne = joke.value(forKey: "firstLine") as! String
            let lineTwo = joke.value(forKey: "secondLine") as! String
            let lineThree = joke.value(forKey: "thirdLine") as! String
            let lineAnswer = joke.value(forKey: "answerLine") as! String
            let dataJoke = Joke(firstLine: lineOne, secondLine: lineTwo, thirdLine: lineThree, answerLine: lineAnswer)
            
            tableJokes.jokes.append (dataJoke)
            self.tableView.reloadData()
        }
    }
}
