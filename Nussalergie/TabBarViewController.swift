//
//  TabBarViewController.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 05.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit
import FontAwesome

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.items?.first?.image = UIImage.fontAwesomeIconWithName(.Archive, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        self.tabBar.items?[1].image = UIImage.fontAwesomeIconWithName(.List, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        self.tabBar.items?[2].image = UIImage.fontAwesomeIconWithName(.Barcode, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))

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
