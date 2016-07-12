//
//  Einkaufszutat.swift
//  Nussalergie
//
//  Created by timi on 12.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation

struct Einkaufszutat {
    let zutat: RezeptZutat
    let taken: Bool
    
    init(zutat: RezeptZutat, taken: Bool){
        self.zutat = zutat
        self.taken = taken
      
    }
}