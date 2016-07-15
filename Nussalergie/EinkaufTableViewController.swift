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
    
    
    var einkaufListenElementeArray = [RezeptZutat(name: "Eier", menge: 5, einheit: "Stk"),RezeptZutat(name: "Donut", menge: 1, einheit: "Stk")]
    var einkaufListenTakenElementeArray = [RezeptZutat(name: "Mehl", menge: 500, einheit: "g")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Einkaufsliste"
        
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
        
        if clickedButtonIndexPath.section == 0 {
            einkaufListenTakenElementeArray.append(einkaufListenElementeArray[clickedButtonIndexPath.row])
            einkaufListenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        } else {
            einkaufListenElementeArray.append(einkaufListenTakenElementeArray[clickedButtonIndexPath.row])
            einkaufListenTakenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        }
        tableView.reloadData()
    }
    
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    
}