//
//  RezeptZutat.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 07.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation

struct RezeptZutat {
    var name: String
    var menge: Int
    var einheit: String
    
    init(name: String, menge: Int, einheit: String){
        self.name = name
        self.menge = menge
        self.einheit = einheit
    }
    
    init(){
        self.name = ""
        self.menge = 0
        self.einheit = ""
    }
}
