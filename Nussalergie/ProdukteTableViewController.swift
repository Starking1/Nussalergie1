//
//  ProdukteTableViewController.swift
//  Nussalergie
//
//  Created by timi on 06.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase


class ProdukteTableViewController: UITableViewController {
    
    let rootRef = FIRDatabase.database().reference()
    let storRef = FIRStorage.storage().reference().child("images/")
    
    var produktarray = [Produkt] ()
    

override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    rootRef.child("Produkte").observeEventType(.Value) { (snap: FIRDataSnapshot) in
        for child in snap.children{
            
            // Download in memory with a maximum allowed size of 3MB (3 * 1024 * 1024 bytes)
            self.storRef.child(child.value!["bild"] as! String).dataWithMaxSize(3 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    let downloadedImage: UIImage! = UIImage(data: data!)
                    self.produktarray.append(Produkt(name: child.value?["name"] as! String, preis: child.value?["preis"] as! Double,
                        menge: child.value?["menge"] as! Int,
                        einheit: child.value?["einheit"] as! String,
                        image: downloadedImage ))
                    self.tableView.reloadData()
                }
            }
        }
    }
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