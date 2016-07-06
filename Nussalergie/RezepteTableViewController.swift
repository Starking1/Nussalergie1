//
//  RezepteTableViewController.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 05.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit

class RezepteTableViewController: UITableViewController {
    
    
    let rezepteArray = [Rezept(name: "Burger", zeit: 30, image: UIImage(named: "burger.jpg")!),
                        Rezept(name: "Spareribs", zeit: 40, image: UIImage(named: "spareribs.jpg")!),
                        Rezept(name: "Brot", zeit: 25, image: UIImage(named: "brot.jpg")!),
                        Rezept(name: "Salz", zeit: 0, image: UIImage(named: "salz.jpg")!),
                        Rezept(name: "Apfel", zeit: 69, image: UIImage(named: "apfel.jpg")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rezepteArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rezeptCell", forIndexPath: indexPath)
        
        let rezept = rezepteArray[indexPath.row] as Rezept
        
        if let rezeptCellImageView = cell.viewWithTag(1) as? UIImageView {
            rezeptCellImageView.image = rezept.image
        }
        if let rezeptCellTitleLabel = cell.viewWithTag(2) as? UILabel {
            rezeptCellTitleLabel.text = rezept.name
        }
        if let rezeptCellTimeLabel = cell.viewWithTag(3) as? UILabel {
            rezeptCellTimeLabel.text = "Zeit: \(rezept.zeit)min"
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "rezeptDetailSegue"{
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            
            let rezept = rezepteArray[indexPath.row]
            
            let rezeptDetailViewController = segue.destinationViewController as! RezepteDetailViewController
            rezeptDetailViewController.rezeptImageView.image = rezept.image
            rezeptDetailViewController.rezeptNavigationTitle = rezept.name
        
           
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
