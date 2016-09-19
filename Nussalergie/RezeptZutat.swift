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

infix operator  +++{ associativity left precedence 140 }
func +++(left: [RezeptZutat], right: [RezeptZutat]) -> [RezeptZutat] {
    var leftArray = left
    var rightArray = right
    
    for object in leftArray {
        for (i,object2) in rightArray.enumerate() {
            if object2.name == object.name {
                object.menge += object2.menge
                rightArray.removeAtIndex(i)
            }
        }
    }
    leftArray += rightArray
    
    
    return leftArray
}

infix operator  +++={ associativity left precedence 140 }
func +++=(inout left: [RezeptZutat], right: [RezeptZutat]) {
    var rightArray = right
    
    for object in left {
        for (i,object2) in rightArray.enumerate() {
            if object2.name == object.name {
                object.menge += object2.menge
                rightArray.removeAtIndex(i)
            }
        }
    }
    left += rightArray
}

infix operator  ---{ associativity left precedence 140 }
func ---(left: [RezeptZutat], right: [RezeptZutat]) -> [RezeptZutat] {
    let leftArray = left
    var rightArray = right
    
    for object in leftArray {
        for (i,object2) in rightArray.enumerate() {
            if object2.name == object.name {
                object.menge -= object2.menge
                rightArray.removeAtIndex(i)
            }
        }
    }
    
    return leftArray
}

infix operator  ---={ associativity left precedence 140 }
func ---=(inout left: [RezeptZutat], right: [RezeptZutat]) {
    var rightArray = right
    
    for object in left {
        for (i,object2) in rightArray.enumerate() {
            if object2.name == object.name {
                object.menge -= object2.menge
                rightArray.removeAtIndex(i)
            }
        }
    }
}
func *(left: [RezeptZutat], right: Int) -> [RezeptZutat]{
    for object in left{
        object.menge *= right
    }
    return left
}

func *= (inout left: [RezeptZutat], right: Float){
    for object in left{
        object.menge = Int(round(Float(object.menge) * right))
    }
}

func / (left: [RezeptZutat], right: Float) -> [RezeptZutat]{
    let leftcopy = left
    for object in leftcopy{
        object.menge = Int(round(Float(object.menge)/right))
    }
    return leftcopy
}


func /= (inout left: [RezeptZutat], right: Float){
    for object in left{
        object.menge = Int(round(Float(object.menge)/right))
    }
}

