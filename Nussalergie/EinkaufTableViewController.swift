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
    
    
    var einkaufListenElementeArray = [Einkaufszutat]()
    
    var alreadyTaken: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for  i in 0 ..< einkaufListenElementeArray.count{
            if (einkaufListenElementeArray[i].taken){
                
                alreadyTaken += 1
            }
        }
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return (einkaufListenElementeArray.count - alreadyTaken)
        }
        else {
            return alreadyTaken
            
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Einkaufszutatcell", forIndexPath: indexPath)
        
        
        if indexPath.section == 0{
            
            let einkaufZutat = einkaufListenElementeArray[indexPath.row] as Einkaufszutat
            if !einkaufZutat.taken {
                if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
                    ZutatCellTitleLabel.text = einkaufZutat.zutat.name
                }
                if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
                    ZutatCellamountLabel.text = "\(einkaufZutat.zutat.menge)  \(einkaufZutat.zutat.einheit)"
                }
                
            } else {
                let einkaufZutat = einkaufListenElementeArray[indexPath.row] as Einkaufszutat
                if einkaufZutat.taken {
                    if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
                        ZutatCellTitleLabel.text = einkaufZutat.zutat.name
                    }
                    if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
                        ZutatCellamountLabel.text = "\(einkaufZutat.zutat.menge)  \(einkaufZutat.zutat.einheit)"
                    }
                }
            }
        }
        return cell
    }
    
    
}