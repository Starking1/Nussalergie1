//
//  EinkaufTableViewController.swift
//  Nussalergie
//
//  Created by timi on 12.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class EinkaufTableViewController: UITableViewController {
    
    
    var einkaufListenElementeArray = [RezeptZutat]()
    var einkaufListenTakenElementeArray = [RezeptZutat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Einkaufsliste"
        
        
        let button = UIBarButtonItem(image: UIImage.fontAwesomeIconWithName(.Archive, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30)), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(deletestuff))
        self.navigationItem.rightBarButtonItem = button
        
        populateTableView()
        
    }
    
    func deletestuff (){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("einkaufsListe")
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return einkaufListenElementeArray.count
        }
        else {
            return einkaufListenTakenElementeArray.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Einkaufsliste"
        }
        else {
            return "Gefunden"
        }
    }
    
    func populateTableView(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let decoded  = userDefaults.objectForKey("einkaufsListe") as? NSData{
            let decodedEinkaufslisteArray = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [RezeptZutat]
            einkaufListenElementeArray = decodedEinkaufslisteArray
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Einkaufszutatcell", forIndexPath: indexPath)
        
        var einkaufZutat = RezeptZutat()
        var buttonImage = UIImage()
        
        
        //Hier werden Werte für die Cell Gesetzt
        if indexPath.section == 0{
            einkaufZutat = einkaufListenElementeArray[indexPath.row] as RezeptZutat
            buttonImage = UIImage.fontAwesomeIconWithName(.CircleO, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        } else if indexPath.section == 1 {
            einkaufZutat = einkaufListenTakenElementeArray[indexPath.row] as RezeptZutat
            buttonImage = UIImage.fontAwesomeIconWithName(.CheckCircleO, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        }
        
        //Cell Immer Gleich muss nicht 2 mal in if-else geschrieben werden
        if let zutatenTakenButton = cell.viewWithTag(3) as? UIButton{
            zutatenTakenButton.setTitle("", forState: .Normal)
            zutatenTakenButton.setImage(buttonImage, forState: .Normal)
            zutatenTakenButton.addTarget(self, action: #selector(pressedTakenButton), forControlEvents: .TouchUpInside)
        }
        if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
            ZutatCellTitleLabel.text = einkaufZutat.name
        }
        if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
            
            ZutatCellamountLabel.text = "\(einkaufZutat.menge)  \(einkaufZutat.einheit)"
        }
        
        return cell
    }
    
    //Eine Funktion Genügt IndexPath.section kann hier abgefragt werden
    func pressedTakenButton (sender: UIButton!){
        let touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: tableView)
        let clickedButtonIndexPath: NSIndexPath = tableView.indexPathForRowAtPoint(touchPoint)!
        
        tableView.beginUpdates()
        if clickedButtonIndexPath.section == 0 {
            einkaufListenTakenElementeArray.append(einkaufListenElementeArray[clickedButtonIndexPath.row])
            tableView.deleteRowsAtIndexPaths([clickedButtonIndexPath], withRowAnimation: .Left)
            let newIndexPath = NSIndexPath(forRow: einkaufListenTakenElementeArray.count - 1, inSection: 1)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Right)
            einkaufListenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        } else {
            einkaufListenElementeArray.append(einkaufListenTakenElementeArray[clickedButtonIndexPath.row])
            tableView.deleteRowsAtIndexPaths([clickedButtonIndexPath], withRowAnimation: .Right)
            let newIndexPath = NSIndexPath(forRow: einkaufListenElementeArray.count - 1, inSection: 0)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Left) 
            einkaufListenTakenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        }
        tableView.endUpdates()
        
    }
    
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    
}