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
    var id: Int
    var name: String
    var zeit: Int
    var image: UIImage
    
    init(id: Int, name: String, zeit: Int, image: UIImage){
        self.id = id
        self.name = name
        self.zeit = zeit
        self.image = image
    }
}
