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
    
    let notification = CWStatusBarNotification()
    
    let rezeptImageView: UIImageView = UIImageView()
    var rezeptNavigationTitle: String = String()
    let rezeptDescriptionLabel: UILabel = UILabel()
    var rezeptID: String = String()
    
    let anzahlView: UIView = UIView()
    var anzahlTextLabel: UILabel = UILabel()
    var anzahlStepperTextLabel: UILabel = UILabel()
    let anzahlStepper: UIStepper = UIStepper()
    
    let scrollView: UIScrollView = UIScrollView()
    let zutatenTableView: UITableView = UITableView()
    
    var zutatenArray = [RezeptZutat]()
    
    var zubereitungsDict = [String : AnyObject]()
    
    let zutatenRef =  FIRDatabase.database().reference().child("Zutaten")
    
    let ursprungAnzahl:Float = 4.0
    var alteStepperValue:Float = 4.0
    var einSchritt:[RezeptZutat] = [RezeptZutat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zubereitungsRef =  FIRDatabase.database().reference().child("Zubereitung").child("\(rezeptID)")
        
        zutatenTableView.delegate = self
        zutatenTableView.dataSource = self
        zutatenTableView.scrollEnabled = false
        zutatenTableView.registerNib(UINib(nibName: "ZutatenCell", bundle: nil), forCellReuseIdentifier: "zutatenCell")
        
        //NavigationBar Setzen
        let button = UIBarButtonItem(image: UIImage.fontAwesomeIconWithName(.PencilSquareO, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
            , style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addToEinkaufsListeButtonPressed))
        self.navigationItem.title = rezeptNavigationTitle
        self.navigationItem.rightBarButtonItem = button
        
        
        //ScrollView initialisieren
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
            
        //Elemente für ScrollView initialisieren
        rezeptImageView.frame = CGRectMake(5, 5,view.frame.width-10,view.frame.width-10)
        //rezeptImageView.backgroundColor = UIColor.blackColor()
        
        //AnzahlView initialisieren
        anzahlView.frame = CGRectMake(5, self.rezeptImageView.frame.size.height + 10, self.view.frame.width-10, 40)
        anzahlTextLabel.text = "Anzahl"
        anzahlTextLabel.frame = CGRectMake(10, 0, 30, 30)
        anzahlTextLabel.center.y = anzahlView.frame.height / 2
        anzahlTextLabel.sizeToFit()
        
        anzahlStepper.frame = CGRectMake(anzahlView.frame.width - 94, 0, 0, 0)
        
        anzahlStepper.minimumValue = 1
        anzahlStepper.maximumValue = 40
        anzahlStepper.value = 4
        anzahlStepper.addTarget(self, action: #selector(stepperPressed), forControlEvents: .ValueChanged)

       
        
        anzahlStepperTextLabel.text = Int(anzahlStepper.value).description
        anzahlStepperTextLabel.frame = CGRectMake(anzahlView.frame.width - anzahlStepper.frame.width - 22, 0, 30, 30)
        anzahlStepperTextLabel.center.y = anzahlView.frame.height / 2
        anzahlStepperTextLabel.sizeToFit()
        
        anzahlView.addSubview(anzahlStepperTextLabel)
        anzahlView.addSubview(anzahlStepper)
        anzahlView.addSubview(anzahlTextLabel)
        
        
        
        zubereitungsRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.zubereitungsDict = snapshot.value as! [String : AnyObject]
            self.rezeptDescriptionLabel.text = self.zubereitungsDict["text"] as? String
            
            
            self.zutatenTableView.frame = CGRectMake(5, self.anzahlView.frame.size.height + self.rezeptImageView.frame.height + 5, self.view.frame.width-10, 0)
         //   self.zutatenTableView.backgroundColor = UIColor.blueColor()
            
            
            self.rezeptDescriptionLabel.frame = CGRectMake(5, self.rezeptImageView.frame.height + self.zutatenTableView.frame.height, self.view.frame.width-10, 500)
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
        scrollView.addSubview(anzahlView)
        scrollView.addSubview(zutatenTableView)
        scrollView.addSubview(rezeptDescriptionLabel)
        view.addSubview(scrollView)
        
        
        
    }
    
    func stepperPressed(sender: UIStepper!){
        anzahlStepperTextLabel.text = Int(anzahlStepper.value).description
        anzahlStepperTextLabel.sizeToFit()
        zutatenArray /= alteStepperValue
        zutatenArray *= Float(anzahlStepper.value)
        alteStepperValue = Float(anzahlStepper.value)
        self.zutatenTableView.reloadData()
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
            self.zutatenRef.child(id).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let zutat = snapshot.value as! [String: String]
                
                self.zutatenArray.append(RezeptZutat(name: zutat["name"]!, menge: (zutatenDictArray[i]["menge"] as! Int), einheit: zutat["einheit"]!))
                self.zutatenTableView.frame.size.height = CGFloat(self.zutatenArray.count * 44)
                
                self.zutatenTableView.reloadData()
                self.rezeptDescriptionLabel.frame.origin.y = (self.anzahlView.frame.size.height + self.rezeptImageView.frame.height + self.zutatenTableView.frame.height + 10)
                self.scrollView.contentSize.height = self.rezeptImageView.frame.height + self.anzahlView.frame.height + self.zutatenTableView.frame.height + self.rezeptDescriptionLabel.frame.height + 40
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func addToEinkaufsListeButtonPressed(sender: UIButton!){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let zutatenFurEinkaufsliste = zutatenArray
        var neueEinkaufsliste = [RezeptZutat]()
        
        if let decoded  = userDefaults.objectForKey("einkaufsListe") as? NSData{
            let decodedEinkaufslisteArray = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [RezeptZutat]
            neueEinkaufsliste = decodedEinkaufslisteArray +++ zutatenFurEinkaufsliste
            
        } else {
            neueEinkaufsliste = zutatenFurEinkaufsliste 
        }
        
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(neueEinkaufsliste)
        
        userDefaults.setObject(encodedData, forKey: "einkaufsListe")
        userDefaults.synchronize()
        displayAddedToEinkaufslisteNotification()
    }
    
    func displayAddedToEinkaufslisteNotification(){
        self.notification.notificationStyle = .NavigationBarNotification
        self.notification.notificationAnimationInStyle = .Bottom
        self.notification.notificationAnimationOutStyle = .Top
        self.notification.notificationLabelBackgroundColor = UIColor(red: 0.2314, green: 0.8559, blue: 0.596, alpha: 1.0)
        self.notification.notificationLabelTextColor = UIColor.whiteColor()
        self.notification.notificationLabelFont = UIFont(name: "Helvetica Neue", size: 15.0)!
        self.notification.displayNotificationWithMessage("Zur Einkaufsliste Hinzugefügt", forDuration: 1.0)
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
