//
//  Orc.swift
//  OOP-exercise
//
//  Created by Tobias Gozzi on 20.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation

class Orc: Character {
    private var _type = ""
    
    var type : String {
        return _type
    }
    
    convenience init(attackpower: Int, hp: Int, name: String, type: String){
        self.init(attackpower: attackpower, hp: hp, name: name)
        _type = type
    }
    
}