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
        
        
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return einkaufListenElementeArray.count
        }
        if section == 1 {
            return einkaufListenTakenElementeArray.count
            
        } else {
            
            return 0
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Einkaufszutatcell", forIndexPath: indexPath)
        
        if indexPath.section == 0{
            
            let einkaufZutat = einkaufListenElementeArray[indexPath.row] as RezeptZutat
            
            if let zutatenTakenButton = cell.viewWithTag(3) as? UIButton{
                zutatenTakenButton.setTitle("Check", forState: .Normal)
                zutatenTakenButton.addTarget(self, action: #selector(pressedTakenButton), forControlEvents: .TouchUpInside)
            }
            
                if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
                    ZutatCellTitleLabel.text = einkaufZutat.name
                }
                if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {

                    ZutatCellamountLabel.text = "\(einkaufZutat.menge)  \(einkaufZutat.einheit)"
            }
                
        } else {
            let einkaufZutat = einkaufListenTakenElementeArray[indexPath.row] as RezeptZutat
            
            if let zutatenTakenButton = cell.viewWithTag(3) as? UIButton{
                zutatenTakenButton.setTitle("Uncheck", forState: .Normal)
                zutatenTakenButton.addTarget(self, action: #selector(pressedUnTakenButton), forControlEvents: .TouchUpInside)
              
            }
            
                if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
                    ZutatCellTitleLabel.text = einkaufZutat.name
                }
                if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
                    ZutatCellamountLabel.text = "\(einkaufZutat.menge)  \(einkaufZutat.einheit)"
            }
            
        }
        return cell
    }
    
    
    func pressedTakenButton (sender: UIButton!){
        let touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: tableView)
        let clickedButtonIndexPath: NSIndexPath = tableView.indexPathForRowAtPoint(touchPoint)!
        print(einkaufListenElementeArray[clickedButtonIndexPath.row].name)
        einkaufListenTakenElementeArray.append(einkaufListenElementeArray[clickedButtonIndexPath.row])
        einkaufListenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        tableView.reloadData()
   
       
        
    }
    
    func pressedUnTakenButton (sender: UIButton!){
        let touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: tableView)
        let clickedButtonIndexPath: NSIndexPath = tableView.indexPathForRowAtPoint(touchPoint)!
       print(einkaufListenTakenElementeArray[clickedButtonIndexPath.row].name)
        einkaufListenElementeArray.append(einkaufListenTakenElementeArray[clickedButtonIndexPath.row])
        einkaufListenTakenElementeArray.removeAtIndex(clickedButtonIndexPath.row)
        tableView.reloadData()
   
        
        
    }
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
}