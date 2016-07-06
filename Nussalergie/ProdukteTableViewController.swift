//
//  ProdukteTableViewController.swift
//  Nussalergie
//
//  Created by timi on 06.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit

class ProdukteTableViewController: UITableViewController {
    
    
    let produktarray = [Produkt(name: "Apfel" , preis: 1.10, menge: 1, einheit: "Stück",image: UIImage(named: "apfel.jpg")!)]
    

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

    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produktarray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("produktCell", forIndexPath: indexPath)
        
        let produkt = produktarray[indexPath.row] as Produkt
        
        if let produktCellImageView = cell.viewWithTag(1) as? UIImageView {
            produktCellImageView.image = produkt.image
        }
        if let produktCellTitleLabel = cell.viewWithTag(2) as? UILabel {
            produktCellTitleLabel.text = produkt.name
        }
        if let produktCellPriceLabel = cell.viewWithTag(3) as? UILabel {
            produktCellPriceLabel.text = "Kostet: \(produkt.preis) CHF"
        }
        if let produktCellAmountLabel = cell.viewWithTag(4) as? UILabel {
            produktCellAmountLabel.text = "\(produkt.menge) " + produkt.einheit
        }
        
        
        return cell
    }
    
    
    
    
    
}