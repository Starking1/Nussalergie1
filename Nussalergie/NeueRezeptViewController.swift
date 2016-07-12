//
//  NeueRezeptViewController.swift
//  Nussalergie
//
//  Created by timi on 08.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class NeueRezeptViewController: UIViewController {
    
    let rezeptNavigationTitle: String = "Neues Rezept"
    let rezeptImageView: UIImageView = UIImageView()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.title = "Neues Rezept"
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        
        rezeptImageView.frame = CGRectMake(view.frame.width - ImageViewwidth - 20, 20 ,ImageViewwidth,ImageViewwidth)
        rezeptImageView.backgroundColor = UIColor.blackColor()
        
        rezeptNameLabel.frame = CGRectMake(20, 20, 100, 30)
        rezeptNameLabel.text = "Name"
        
        rezeptNameTextfield.frame = CGRectMake(20, 55, 100, 30)
        rezeptNameTextfield.backgroundColor = UIColor.greenColor()
        
        rezeptDauerLabel.frame = CGRectMake(20, 100, 100, 30)
        rezeptDauerLabel.text = "Dauer"
        
        rezeptDauerTextfield.frame = CGRectMake(20, 135, 100, 30)
        rezeptDauerTextfield.backgroundColor = UIColor.greenColor()
        
        rezeptZubereitungLabel.frame = CGRectMake(20, 180, 100, 30)
        rezeptZubereitungLabel.text = "Zubereitung"
        
        rezeptZubereitungsTextfield.frame = CGRectMake(20, 205,view.frame.width - 40 , ZubereitungsTextfieldheight)
        rezeptZubereitungsTextfield.backgroundColor = UIColor.greenColor()
        
        
        rezeptZutatenLabel.frame = CGRectMake(20, 210 + ZubereitungsTextfieldheight + 10, 100, 30)
        rezeptZutatenLabel.text = "Zutaten"
        
        rezeptZutatenButton.frame = CGRectMake(view.frame.width - 120, 210 + ZubereitungsTextfieldheight + 10, 100, 30)
        rezeptZutatenButton.setTitle("Posten", forState: .Normal)
        rezeptZutatenButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        rezeptZutatenButton.addTarget(self, action: #selector(pressedPostButton), forControlEvents: .TouchUpInside)

        scrollView.addSubview(rezeptImageView)
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
        print(rezeptNameTextfield.text)
        print(rezeptDauerTextfield.text)
        print(rezeptZubereitungsTextfield.text)
    }
    
}
