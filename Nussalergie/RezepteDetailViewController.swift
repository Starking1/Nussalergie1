//
//  RezepteDetailViewController.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 06.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import Firebase

class RezepteDetailViewController: UIViewController {
    
    let rezeptImageView: UIImageView = UIImageView()
    var rezeptNavigationTitle: String = String()
    let rezeptDescriptionLabel: UILabel = UILabel()
    var rezeptID: Int = Int()
    
    let scrollView: UIScrollView = UIScrollView()
    let zutatenTableView: UITableView = UITableView()
    
    
    //let zubereitungsRef = FIRDatabase.database().reference().child("Zubereitung").child("0")
    let zutatenRef =  FIRDatabase.database().reference().child("Zutaten").child("0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zutatenRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            print(snapshot)
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //NavigationBarTitel Setzen
        self.navigationItem.title = rezeptNavigationTitle
        
        //ScrollView initialisieren
        scrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
            
        //Elemente für ScrollView initialisieren
        rezeptImageView.frame = CGRectMake(5, 5,view.frame.width-10,view.frame.width-10)
        //rezeptImageView.backgroundColor = UIColor.blackColor()
        
        rezeptDescriptionLabel.frame = CGRectMake(5, rezeptImageView.frame.height + 20, view.frame.width-10, 500)
        rezeptDescriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius adipisci, sed libero. Iste asperiores suscipit, consequatur debitis animi impedit numquam facilis iusto porro labore dolorem, maxime magni incidunt. Delectus, est! Totam at eius excepturi deleniti sed, error repellat itaque omnis maiores tempora ratione dolor velit minus porro aspernatur repudiandae labore quas adipisci esse, nulla tempore voluptatibus cupiditate. Ab provident, atque. Possimus deserunt nisi perferendis, consequuntur odio et aperiam, est, dicta dolor itaque sunt laborum, magni qui optio illum dolore laudantium similique harum. Eveniet quis, libero eligendi delectus repellendus repudiandae ipsum? Vel nam odio dolorem, voluptas sequi minus quo tempore, animi est quia earum maxime. Reiciendis quae repellat, modi non, veniam natus soluta at optio vitae in excepturi minima eveniet dolor."
        rezeptDescriptionLabel.numberOfLines = 40
        rezeptDescriptionLabel.textColor = UIColor.darkGrayColor()
        rezeptDescriptionLabel.backgroundColor = UIColor(red: 0.9021, green: 0.8982, blue: 0.7637, alpha: 1.0)
        
        zutatenTableView.frame = CGRectMake(5, rezeptImageView.frame.height + rezeptDescriptionLabel.frame.height + 50, view.frame.width-10, 200)
        zutatenTableView.backgroundColor = UIColor.blueColor()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
