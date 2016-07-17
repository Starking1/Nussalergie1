//
//  NeuesProdukt.swift
//  Nussalergie
//
//  Created by timi on 17.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase
import ImagePickerSheetController

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
        
        view.addSubview(scrollView)
        
        
        
    }
    
    
    func pressedTakePicture (sender: UIButton!){
 //       presentImagePickerSheet()
    }
    
}
