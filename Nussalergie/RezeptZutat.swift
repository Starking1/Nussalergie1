//
//  RezeptZutat.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 07.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation

struct RezeptZutat {
    let name: String
    let menge: Int
    let einheit: String
    
    init(name: String, menge: Int, einheit: String){
        self.name = name
        self.menge = menge
        self.einheit = einheit
    }
}
