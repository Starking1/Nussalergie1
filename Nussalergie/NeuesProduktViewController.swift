//
//  NeuesProdukt.swift
//  Nussalergie
//
//  Created by timi on 17.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class NeuesProduktNeuesProduktViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    let produktNavigationTitle: String = "Neues Rezept"
    let produktImageView: UIImageView = UIImageView()
    let produktImageViewOverlayButton: UIButton = UIButton()
    let ImageViewwidth: CGFloat = 150;
    let produktNameLabel: UILabel = UILabel()
    let produktNameTextfield: UITextField = UITextField()
    let produktMengeLabel: UILabel = UILabel()
    let produktMengeTextfield: UITextField = UITextField()
    let produktKostenLabel: UILabel = UILabel()
    let produktKostenTextfield: UITextField = UITextField()
    let produktEinheitLabel: UILabel = UILabel()
    let produktEinheitTextfield: UITextField = UITextField()
    let produktZutatenNameLabel:UILabel = UILabel()
    let produktZutatenNameTextfield: UITextField = UITextField()
    let postenButton: UIButton = UIButton()
    
    let scrollView: UIScrollView = UIScrollView()

    
    let rootRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()

    var imagePicker: UIImagePickerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Neues Produkt"
        
        
        
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        
        produktImageView.frame = CGRectMake(view.frame.width - ImageViewwidth - 20, 20 ,ImageViewwidth,ImageViewwidth)
        produktImageView.backgroundColor = UIColor.lightGrayColor()
        produktImageView.image = UIImage.fontAwesomeIconWithName(.Camera, textColor: UIColor.blackColor(), size: CGSize(width: 50, height: 50))
        produktImageView.layer.zPosition = -1
        produktImageViewOverlayButton.frame = produktImageView.frame
        produktImageViewOverlayButton.addTarget(self, action: #selector(pressedTakePicture), forControlEvents: .TouchUpInside)
        
        
        produktNameLabel.frame = CGRectMake(20, 20, 100, 30)
        produktNameLabel.text = "Name"
        
        produktNameTextfield.frame = CGRectMake(20, 55, 100, 30)
        produktNameTextfield.backgroundColor = UIColor.greenColor()
//        produktNameTextfield.addTarget(self, action: #selector(textFieldDidChange), forControlEvents:UIControlEvents.EditingChanged)
        
        produktKostenLabel.frame = CGRectMake(20, 100, 100, 30)
        produktKostenLabel.text = "Kosten"
        
        produktKostenTextfield.frame = CGRectMake(20, 135, 100, 30)
        produktKostenTextfield.keyboardType = .NumberPad
        produktKostenTextfield.backgroundColor = UIColor.greenColor()
        
        produktZutatenNameLabel.frame = CGRectMake(20, 180, 200, 30)
        produktZutatenNameLabel.text = "Zutatenname"
        
        produktZutatenNameTextfield.frame = CGRectMake(20, 215, 100, 30)
        produktZutatenNameTextfield.backgroundColor = UIColor.greenColor()
        
        
        
        produktMengeLabel.frame = CGRectMake(20, 260, 100, 30)
        produktMengeLabel.text = "Menge"
        
        produktMengeTextfield.frame = CGRectMake(20, 295, 100, 30)
        produktMengeTextfield.keyboardType = .NumberPad
        produktMengeTextfield.backgroundColor = UIColor.greenColor()
        
        produktEinheitLabel.frame = CGRectMake(120, 260, 100, 30)
        produktEinheitLabel.text = "Einheit"
        
        produktEinheitTextfield.frame = CGRectMake(120, 295, 100, 30)
        produktEinheitTextfield.backgroundColor = UIColor.greenColor()
        
        postenButton.frame = CGRectMake(20, 340 , 100, 30)
        postenButton.setTitle("Posten", forState: .Normal)
        postenButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        postenButton.addTarget(self, action: Selector(), forControlEvents: .TouchUpInside)

      
        scrollView.addSubview(produktImageView)
        scrollView.addSubview(produktImageViewOverlayButton)
        scrollView.addSubview(produktNameLabel)
        scrollView.addSubview(produktNameTextfield)
        scrollView.addSubview(produktKostenLabel)
        scrollView.addSubview(produktKostenTextfield)
        scrollView.addSubview(produktEinheitLabel)
        scrollView.addSubview(produktEinheitTextfield)
        scrollView.addSubview(produktZutatenNameLabel)
        scrollView.addSubview(produktZutatenNameTextfield)
        
        
        scrollView.addSubview(produktMengeLabel)
        scrollView.addSubview(produktMengeTextfield)
        scrollView.addSubview(postenButton)
        view.addSubview(scrollView)
        
        
        
    }
    func pressedPostButton (sender: UIButton!){
        //Generate Key For Storage
        let key = self.rootRef.childByAutoId().key
        
        
        //Picture Upload First
        // Data in memory
        let data: NSData = UIImageJPEGRepresentation(produktImageView.image!, 0.8)!;
        
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
                            "einheit": self.produktEinheitTextfield.text!,
                            "menge": self.produktMengeTextfield.text!,
                            
                            "name": self.produktNameTextfield.text!,
                            "preis": Double(self.produktKostenTextfield.text!)!]
                
                
                
                let childUpdates = ["/Produkte/\(key)": post]
                self.rootRef.updateChildValues(childUpdates)
            }
        }
    }
    
    
    func pressedTakePicture (sender: UIButton!){
 //       presentImagePickerSheet()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        produktImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        produktImageView.contentMode = .ScaleAspectFit
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
