//
//  ZutatSearchViewController.swift
//  Nussalergie
//
//  Created by timi on 15.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class ZutatSearchViewController: UITableViewController {

    var ausgewahlteZutat = [RezeptZutat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ausgewahlteZutat.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchedZutatCell", forIndexPath: indexPath)
        
        let zutat = ausgewahlteZutat[indexPath.row] as RezeptZutat
        if let zutatCellTitleLabel = cell.viewWithTag(1) as? UILabel {
            zutatCellTitleLabel.text = zutat.name
        }
        if let zutatCellEinheitLabel = cell.viewWithTag(2) as? UILabel {
            zutatCellEinheitLabel.text = zutat.einheit
        }
        if let zutatCellMengeTextfield = cell.viewWithTag(3) as? UITextField {
            print(zutatCellMengeTextfield)
        }
        
        return cell
    }
    
    
}
