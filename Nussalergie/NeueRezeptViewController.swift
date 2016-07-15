//
//  NeueRezeptViewController.swift
//  Nussalergie
//
//  Created by timi on 08.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase
import ImagePickerSheetController

class NeueRezeptViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    var rezeptID: Int = Int()
    let scrollView: UIScrollView = UIScrollView()

    let rootRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Neues Rezept"
        
        
        
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
        rezeptNameTextfield.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        
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
        
        rezeptZutatenButton.frame = CGRectMake(view.frame.width - 120, 210 + ZubereitungsTextfieldheight + 10, 100, 30)
        rezeptZutatenButton.setTitle("Posten", forState: .Normal)
        rezeptZutatenButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        rezeptZutatenButton.addTarget(self, action: #selector(pressedPostButton), forControlEvents: .TouchUpInside)

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
        
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
//            // ...
//        }
//        alertController.addAction(cancelAction)
//        
//        let OKAction = UIAlertAction(title: "Neues Foto", style: .Default) { (action) in
//            // ...
//        }
//        alertController.addAction(OKAction)
//        
//        let destroyAction = UIAlertAction(title: "Aus Album", style: .Default) { (action) in
//            
//        }
//        alertController.addAction(destroyAction)
//        
//        self.presentViewController(alertController, animated: true) {
//            // ...
//        }
        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .Camera
//        imagePicker.allowsEditing = true
//        
//        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        rezeptImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        rezeptImageView.contentMode = .ScaleAspectFit
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    
    //.addTarget(self, action: #selector(pressedTakePicture), forControlEvents: .TouchUpInside)
    func textFieldDidChange(textField: UITextField) {
       findZutaten(textField.text!)
    }
    
    func findZutaten(text: String)->Void{
        if !text.isEmpty {
        rootRef.child("Zutaten").queryOrderedByChild("name").queryStartingAtValue(text).queryEndingAtValue(text+"\u{f8ff}").observeSingleEventOfType(.Value, withBlock: { snapshot in
            var zutat = RezeptZutat()
            for z in snapshot.children{
                zutat.name = z.value!["name"] as! String
                print(zutat.name)
            }
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
        
        let controller = ImagePickerSheetController(mediaType: .Image)
        controller.maximumSelection = 1
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo Or Video", comment: "Action Title"), handler: { _ in
            presentImagePickerController(.Camera)
            }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Photo Library", comment: "Action Title"), secondaryTitle: { NSString.localizedStringWithFormat(NSLocalizedString("Select Photos", comment: "Action Title"), $0) as String}, handler: { _ in
            presentImagePickerController(.PhotoLibrary)
            }, secondaryHandler: { _, numberOfPhotos in
                print("Send \(controller.selectedImageAssets)")
        }))
        
        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), handler: { _ in
        }))
        
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.modalPresentationStyle = .Popover
            controller.popoverPresentationController?.sourceView = view
            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
