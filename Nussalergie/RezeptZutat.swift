//
//  RezeptZutat.swift
//  Nussalergie
//
//  Created by Lucas Neubauer on 07.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import Foundation

class RezeptZutat: NSObject, NSCoding {
    var name: String
    var menge: Int
    var einheit: String
    
    init(name: String, menge: Int, einheit: String){
        self.name = name
        self.menge = menge
        self.einheit = einheit
    }
    
    override init(){
        self.name = ""
        self.menge = 0
        self.einheit = ""
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let menge = aDecoder.decodeIntegerForKey("menge")
        let einheit = aDecoder.decodeObjectForKey("einheit") as! String
        self.init(name: name, menge: menge, einheit: einheit)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(menge, forKey: "menge")
        aCoder.encodeObject(einheit, forKey: "einheit")
    }
}
