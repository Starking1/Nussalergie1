//
//  NeueRezeptViewController.swift
//  Nussalergie
//
//  Created by timi on 08.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Cocoa

class NeueRezeptViewController: NSViewController {
    
    
    let rezeptImageView: UIImageView = UIImageView()
    let rezeptNameLabel: UILabel = UILabel()
    let rezeptDauerLabel: UILabel = UILabel()
    let rezeptZubereitungLabel: UILabel = UILabel()
    let rezeptNameTextfield: UITextfield
    let rezeptNavigationTitle: String = "Neues Rezept"
    let rezeptDescriptionLabel: UILabel = UILabel()
    var rezeptID: Int = Int()
    
    let scrollView: UIScrollView = UIScrollView()
    let zutatenTableView: UITableView = UITableView()
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
