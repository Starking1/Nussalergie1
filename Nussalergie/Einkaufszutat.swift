//
//  Einkaufszutat.swift
//  Nussalergie
//
//  Created by timi on 12.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation

struct Einkaufszutat {
    let Zutat: RezeptZutat
    let taken: Bool
    
    init(Zutat: RezeptZutat, taken: Bool){
        self.Zutat = Zutat
        self.taken = taken
      
    }
}