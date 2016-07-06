//
//  Produkte.swift
//  Nussalergie
//
//  Created by timi on 06.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation
import UIKit


struct Produkt {
    
    var name: String
    var preis: Double
    var menge: Int
    var einheit: String
    var image: UIImage
    
    init(name: String, preis: Double,menge: Int,einheit: String, image: UIImage){
        self.name = name
        self.preis = preis
        self.menge = menge
        self.einheit = einheit
        self.image = image
    }
    
    
}