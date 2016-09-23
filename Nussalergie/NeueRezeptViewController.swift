//
//  NeueRezeptViewController.swift
//  Nussalergie
//
//  Created by timi on 08.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class NeueRezeptViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let rezeptNavigationTitle: String = "Neues Rezept"
    let rezeptImageView: UIImageView = UIImageView()
    let rezeptImageViewOverlayButton: UIButton = UIButton()
    let ImageViewwidth: CGFloat = 150;
    let rezeptNameLabel: UILabel = UILabel()
    let rezeptNameTextfield: UITextField = UITextField()
    let rezeptDauerLabel: UILabel = UILabel()
    let rezeptDauerTextfield: UITextField = UITextField()
    let rezeptZubereitungLabel: UILabel = UILabel()
    let rezeptZubereitungsTextfield: UITextField = UITextField()
    let ZubereitungsTextfieldheight: CGFloat = 200;
    let rezeptZutatenLabel:UILabel = UILabel()
    let rezeptZutatenButton: UIButton = UIButton()
    let zutatenSearchTextfield: UITextField = UITextField()
    var rezeptID: Int = Int()
    let scrollView: UIScrollView = UIScrollView()
    var zubereitungsDict = [String : AnyObject]()
    let auswahlzutatenTableView: UITableView = UITableView()
    
    var ausgewahlteZutat = [RezeptZutat]()
    var zutatenArray = [RezeptZutat]()
    
    let rootRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()

    let zutatenRef =  FIRDatabase.database().reference().child("Zutaten")
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Neues Rezept"
        
        auswahlzutatenTableView.delegate = self
        auswahlzutatenTableView.dataSource = self
        auswahlzutatenTableView.scrollEnabled = false
        auswahlzutatenTableView.registerNib(UINib(nibName: "SearchedZutat", bundle: nil), forCellReuseIdentifier: "searchedCell")
        
        
        
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        
        rezeptImageView.frame = CGRectMake(view.frame.width - ImageViewwidth - 20, 20 ,ImageViewwidth,ImageViewwidth)
        rezeptImageView.backgroundColor = UIColor.lightGrayColor()
        rezeptImageView.image = UIImage.fontAwesomeIconWithName(.Camera, textColor: UIColor.blackColor(), size: CGSize(width: 50, height: 50))
        rezeptImageView.layer.zPosition = -1
        rezeptImageViewOverlayButton.frame = rezeptImageView.frame
        rezeptImageViewOverlayButton.addTarget(self, action: #selector(pressedTakePicture), forControlEvents: .TouchUpInside)
        
        
        rezeptNameLabel.frame = CGRectMake(20, 20, 100, 30)
        rezeptNameLabel.text = "Name"
        
        rezeptNameTextfield.frame = CGRectMake(20, 55, 100, 30)
        rezeptNameTextfield.backgroundColor = UIColor.greenColor()
        
        rezeptDauerLabel.frame = CGRectMake(20, 100, 100, 30)
        rezeptDauerLabel.text = "Dauer"
        
        rezeptDauerTextfield.frame = CGRectMake(20, 135, 100, 30)
        rezeptDauerTextfield.keyboardType = .NumberPad
        rezeptDauerTextfield.backgroundColor = UIColor.greenColor()
        
        rezeptZubereitungLabel.frame = CGRectMake(20, 180, 100, 30)
        rezeptZubereitungLabel.text = "Zubereitung"
        
        rezeptZubereitungsTextfield.frame = CGRectMake(20, 205,view.frame.width - 40 , ZubereitungsTextfieldheight)
        rezeptZubereitungsTextfield.backgroundColor = UIColor.greenColor()
        rezeptZubereitungsTextfield.contentVerticalAlignment = UIControlContentVerticalAlignment.Top
        rezeptZubereitungsTextfield.delegate = self
        
        
        rezeptZutatenLabel.frame = CGRectMake(20, 210 + ZubereitungsTextfieldheight + 10, 100, 30)
        rezeptZutatenLabel.text = "Zutaten"
        zutatenSearchTextfield.frame = CGRectMake(20,250 + ZubereitungsTextfieldheight + 10,view.frame.width - 40,30)
        zutatenSearchTextfield.placeholder = "neue Zutat"
        zutatenSearchTextfield.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        
            
            auswahlzutatenTableView.frame = CGRectMake(5, 290 + ZubereitungsTextfieldheight + 10, self.view.frame.width-10, 0)
        //    auswahlzutatenTableView.backgroundColor = UIColor.blueColor()
            
         
        rezeptZutatenButton.frame = CGRectMake(view.frame.width - 120, 210 + ZubereitungsTextfieldheight + 10, 100, 30)
        rezeptZutatenButton.setTitle("Posten", forState: .Normal)
        rezeptZutatenButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        rezeptZutatenButton.addTarget(self, action: Selector(), forControlEvents: .TouchUpInside)

        scrollView.addSubview(rezeptImageView)
        scrollView.addSubview(rezeptImageViewOverlayButton)
        scrollView.addSubview(rezeptNameLabel)
        scrollView.addSubview(rezeptNameTextfield)
        scrollView.addSubview(rezeptDauerLabel)
        scrollView.addSubview(rezeptDauerTextfield)
        scrollView.addSubview(rezeptZubereitungLabel)
        scrollView.addSubview(rezeptZubereitungsTextfield)
        scrollView.addSubview(rezeptZutatenLabel)
        scrollView.addSubview(rezeptZutatenButton)
        scrollView.addSubview(zutatenSearchTextfield)
        scrollView.addSubview(auswahlzutatenTableView)
        view.addSubview(scrollView)
       
        
        
    }
    
    func pressedPostButton (sender: UIButton!){
        //Generate Key For Storage
        let key = self.rootRef.childByAutoId().key
    
        
        //Picture Upload First
        // Data in memory
        let data: NSData = UIImageJPEGRepresentation(rezeptImageView.image!, 0.8)!;
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/\(key).jpg")
        
        //Add metadata
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the file to the path "images/*name*.jpg"
        riversRef.putData(data, metadata: metadata) { metadata, error in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                //let downloadURL = metadata!.downloadURL
                // This can be stored in the Firebase Realtime Database
                // It can also be used by image loading libraries like SDWebImage
                
                let post = ["bild": "\(key).jpg",
                            "name": self.rezeptNameTextfield.text!,
                            "zeit": Int(self.rezeptDauerTextfield.text!)!]
                
                let zubereitung = ["text" : self.rezeptZubereitungsTextfield.text!,
                                   "zutaten" : [["id" : 4,
                                    "menge" : 250],
                                    ["id": 5,
                                        "menge": 500]]]

                let childUpdates = ["/Rezepte/\(key)": post,
                                    "/Zubereitung/\(key)": zubereitung]
                self.rootRef.updateChildValues(childUpdates)
            }
        }
    }
    
    func pressedTakePicture (sender: UIButton!){
        presentImagePickerSheet()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        rezeptImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        rezeptImageView.contentMode = .ScaleAspectFit
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    
    //.addTarget(self, action: #selector(pressedTakePicture), forControlEvents: .TouchUpInside)
    func textFieldDidChange(textField: UISearchBar) {
        findZutatenneuesRezept(textField.text!)
   
       self.ausgewahlteZutat.removeAll()
    }
    
    func findZutatenneuesRezept(text: String)->Void{
        if !text.isEmpty {
            rootRef.child("Zutaten").queryOrderedByChild("name").queryStartingAtValue(text).queryEndingAtValue(text+"\u{f8ff}").observeSingleEventOfType(.Value , withBlock: { snapshot in
                for z in snapshot.children{
                    let zutat = RezeptZutat()
                    zutat.name = z.value!["name"] as! String
                    zutat.einheit = z.value!["einheit"] as! String
                    print(zutat.name)
                    self.ausgewahlteZutat.append(zutat)
                    print(self.ausgewahlteZutat.description)
                }
                self.populateZutatenTableView()
        })
        }
        
    }
    
    
    func presentImagePickerSheet() {
        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
            let controller = UIImagePickerController()
            controller.delegate = self
            var sourceType = source
            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
                sourceType = .PhotoLibrary
                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
            }
            controller.sourceType = sourceType
            controller.allowsEditing = true
            self.presentViewController(controller, animated: true, completion: nil)
        }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {(action) in
        }
        alertController.addAction(cancelAction)
        let newPhotoAction = UIAlertAction(title: "Neues Foto Aufnehmen", style: .Default) { (action) in
            presentImagePickerController(.Camera)
        }
        alertController.addAction(newPhotoAction)
        let photoLibAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) in
            presentImagePickerController(.PhotoLibrary)
        }
        alertController.addAction(photoLibAction)
        self.presentViewController(alertController, animated: true) {}
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return ausgewahlteZutat.count
        }
        else{
            return zutatenArray.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchedCell", forIndexPath: indexPath)
        var zutat = RezeptZutat()
        let zutatenCellTextField = cell.viewWithTag(2) as? UITextField
        var buttonImage = UIImage()
        if indexPath.section == 1{
            zutatenCellTextField?.userInteractionEnabled = false
            buttonImage = UIImage.fontAwesomeIconWithName(.CheckCircleO, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
            zutat = zutatenArray[indexPath.row]
            zutatenCellTextField?.text = "\(zutat.menge)"
        }
        if indexPath.section == 0{
            zutatenCellTextField?.userInteractionEnabled = true
            zutatenCellTextField?.text = ""
            buttonImage = UIImage.fontAwesomeIconWithName(.CircleO, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
            zutat = ausgewahlteZutat[indexPath.row]
        }
        
        if let zutatenCellNameLabel = cell.viewWithTag(1) as? UILabel {
            zutatenCellNameLabel.text = zutat.name
        }
        if let zutatenCellEinheitLabel = cell.viewWithTag(3) as? UILabel {
            zutatenCellEinheitLabel.text = zutat.einheit
        }
 
        if let zutatenTakenButton = cell.viewWithTag(4) as? UIButton{
            zutatenTakenButton.setTitle("", forState: .Normal)
            zutatenTakenButton.setImage(buttonImage, forState: .Normal)
            zutatenTakenButton.addTarget(self, action: #selector(pressedTakenButton), forControlEvents: .TouchUpInside)
        }
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func pressedTakenButton (sender: UIButton) {
        let touchPoint: CGPoint = sender.convertPoint(CGPointZero, toView: auswahlzutatenTableView)
        let clickedButtonIndexPath: NSIndexPath = auswahlzutatenTableView.indexPathForRowAtPoint(touchPoint)!
        let thisTextField: UITextField = (auswahlzutatenTableView.cellForRowAtIndexPath(clickedButtonIndexPath)?.viewWithTag(2) as? UITextField)!
        auswahlzutatenTableView.beginUpdates()
        if clickedButtonIndexPath.section == 0{
            var done = false
            for zutat in zutatenArray {
                if (zutat.name == ausgewahlteZutat[clickedButtonIndexPath.row].name){
                    if !(thisTextField.text == "") {
                        zutat.menge += Int(thisTextField.text!)!
                    }
                    done = true;
                }
            }
            if(!done){
                zutatenArray.append(ausgewahlteZutat[clickedButtonIndexPath.row])
                let newIndexPath = NSIndexPath(forRow: zutatenArray.count - 1, inSection:1)
                auswahlzutatenTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Right)
                if !(thisTextField.text == "") {
                    zutatenArray[zutatenArray.count-1].menge = Int(thisTextField.text!)!
                }
                thisTextField.text = ""
            }
            
        } else{
            auswahlzutatenTableView.deleteRowsAtIndexPaths([clickedButtonIndexPath], withRowAnimation: .Right)
            zutatenArray.removeAtIndex(clickedButtonIndexPath.row)
        }
       
        auswahlzutatenTableView.endUpdates()
        populateZutatenTableView()
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func populateZutatenTableView() {
            
                auswahlzutatenTableView.frame.size.height = CGFloat((self.ausgewahlteZutat.count + self.zutatenArray.count) * 44)
                auswahlzutatenTableView.reloadData()
                self.scrollView.contentSize.height = 250 + self.ZubereitungsTextfieldheight + 10 + auswahlzutatenTableView.frame.height + 40
    }
}
