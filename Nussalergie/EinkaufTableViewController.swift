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

    
    var RezeptZutattotake = [Einkaufszutat]()

    var alreadytaken: Int = 0
    
    var ownindex: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for  i in 0 ... RezeptZutattotake.count{
            if (RezeptZutattotake[i].taken){
                
                alreadytaken += 1
            }
        }
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
        return (RezeptZutattotake.count - alreadytaken)
        }
         else {
            return alreadytaken
        
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Einkaufszutatcell", forIndexPath: indexPath)
        
        cell.accessoryType = .DisclosureIndicator
        
        let Zutat = RezeptZutattotake[indexPath.row] as Einkaufszutat
        
        if let ZutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
            ZutatCellTitleLabel.text = Zutat.Zutat.name
        }
        if let ZutatCellamountLabel = cell.viewWithTag(2) as? UILabel {
            ZutatCellamountLabel.text = "\(Zutat.Zutat.menge)  \(Zutat.Zutat.einheit)"
        }
        
        
        return cell
    }
    

    
    
}
