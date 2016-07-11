//
//  RezepteDetailViewController.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 06.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase
import FontAwesome

class RezepteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rezeptImageView: UIImageView = UIImageView()
    var rezeptNavigationTitle: String = String()
    let rezeptDescriptionLabel: UILabel = UILabel()
    var rezeptID: Int = Int()
    
    let scrollView: UIScrollView = UIScrollView()
    let zutatenTableView: UITableView = UITableView()
    
    var zutatenArray = [RezeptZutat]()
    
    var zubereitungsDict = [String : AnyObject]()
    
    let zutatenRef =  FIRDatabase.database().reference().child("Zutaten")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zubereitungsRef =  FIRDatabase.database().reference().child("Zubereitung").child("\(rezeptID)")
        
        zutatenTableView.delegate = self
        zutatenTableView.dataSource = self
        zutatenTableView.registerNib(UINib(nibName: "ZutatenCell", bundle: nil), forCellReuseIdentifier: "zutatenCell")
        
        //NavigationBar Setzen
        let button = UIBarButtonItem()
        button.image = UIImage.fontAwesomeIconWithName(.Archive, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        self.navigationItem.title = rezeptNavigationTitle
        self.navigationItem.rightBarButtonItem = button
        
        //ScrollView initialisieren
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
            
        //Elemente für ScrollView initialisieren
        rezeptImageView.frame = CGRectMake(5, 5,view.frame.width-10,view.frame.width-10)
        //rezeptImageView.backgroundColor = UIColor.blackColor()
        
        
        zubereitungsRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.zubereitungsDict = snapshot.value as! [String : AnyObject]
            self.rezeptDescriptionLabel.text = self.zubereitungsDict["text"] as? String
            
            
            self.zutatenTableView.frame = CGRectMake(5, self.rezeptImageView.frame.height, self.view.frame.width-10, 0)
            self.zutatenTableView.backgroundColor = UIColor.blueColor()
            
            
            
            self.rezeptDescriptionLabel.frame = CGRectMake(5, self.rezeptImageView.frame.height + self.zutatenTableView.frame.height + 20, self.view.frame.width-10, 500)
            self.rezeptDescriptionLabel.numberOfLines = 0
            self.rezeptDescriptionLabel.lineBreakMode = .ByWordWrapping
            self.rezeptDescriptionLabel.sizeToFit()
            self.rezeptDescriptionLabel.frame.size.width = self.view.frame.width-10
            self.rezeptDescriptionLabel.textColor = UIColor.darkGrayColor()
            self.rezeptDescriptionLabel.backgroundColor = UIColor(red: 0.9021, green: 0.8982, blue: 0.7637, alpha: 1.0)
            
            
            self.populateZutatenTableView(self.zubereitungsDict)
            
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
        //Alle Views anzeigen
        scrollView.addSubview(rezeptImageView)
        scrollView.addSubview(rezeptDescriptionLabel)
        scrollView.addSubview(zutatenTableView)
        
        view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zutatenArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("zutatenCell", forIndexPath: indexPath)
        
        let zutat = zutatenArray[indexPath.row]
        
        if let zutatenCellNameLabel = cell.viewWithTag(1) as? UILabel {
            zutatenCellNameLabel.text = zutat.name
        }
        if let zutatenCellMengeLabel = cell.viewWithTag(2) as? UILabel {
            zutatenCellMengeLabel.text = String(zutat.menge)
        }
        if let zutatenCellEinheitLabel = cell.viewWithTag(3) as? UILabel {
            zutatenCellEinheitLabel.text = zutat.einheit
        }
        
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func populateZutatenTableView(zubereitungsDict: NSDictionary) {
        
        let zutatenDictArray = (zubereitungsDict["zutaten"] as! [NSDictionary])
        
        for i in 0..<zutatenDictArray.count{
            let id = String(zutatenDictArray[i]["id"]!)
            self.zutatenRef.child(id).observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
                let zutat = snapshot.value as! [String: String]
                
                self.zutatenArray.append(RezeptZutat(name: zutat["name"]!, menge: (zutatenDictArray[i]["menge"] as! Int), einheit: zutat["einheit"]!))
                self.zutatenTableView.frame.size.height = CGFloat(self.zutatenArray.count * 44)
                self.zutatenTableView.reloadData()
                
                self.rezeptDescriptionLabel.frame.origin.y = (self.rezeptImageView.frame.height + self.zutatenTableView.frame.height + 10)
                self.scrollView.contentSize.height = self.rezeptImageView.frame.height + self.zutatenTableView.frame.height + self.rezeptDescriptionLabel.frame.height + 40
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
    
//
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
