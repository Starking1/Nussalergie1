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
    
    
    var einkaufListenElementeArray = [RezeptZutat(name: "Eier", menge: 5, einheit: "Stk")]
    var einkaufListenTakenElementeArray = [RezeptZutat]()
    
    
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
        else {
            return einkaufListenTakenElementeArray.count
            
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Einkaufszutatcell", forIndexPath: indexPath)
        
        if indexPath.section == 0{
            
            let einkaufZutat = einkaufListenElementeArray[indexPath.row] as RezeptZutat
            
            if let zutatenTakenButton = cell.viewWithTag(3) as? UIButton{
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
    
                if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
                    ZutatCellTitleLabel.text = einkaufZutat.name
                }
                if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
                    ZutatCellamountLabel.text = "\(einkaufZutat.menge)  \(einkaufZutat.einheit)"
            }
            
        }
        return cell
    }
    
    
    func pressedTakenButton (sender: UIButton){
        var touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: EinkaufTableView)
        // maintable --> replace your tableview name
        var clickedButtonIndexPath: NSIndexPath = EinkaufTableView(forRowAtPoint: touchPoint)
        NSLog("index path.section ==%ld", Int(clickedButtonIndexPath.section))
        NSLog("index path.row ==%ld", Int(clickedButtonIndexPath.row))
    }
    
}