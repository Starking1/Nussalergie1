//
//  Rezept.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 05.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation
import UIKit

struct Rezept{
    var id: String
    var name: String
    var zeit: Int
    var image: UIImage
    
    init(id: String, name: String, zeit: Int, image: UIImage){
        self.id = id
        self.name = name
        self.zeit = zeit
        self.image = image
    }
}
