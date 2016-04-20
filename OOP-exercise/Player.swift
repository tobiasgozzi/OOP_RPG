//
//  Player.swift
//  OOP-exercise
//
//  Created by Tobias Gozzi on 18.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation

class Soldier: Character {
    private var _type = ""
   
    var type: String {
        return _type
    }

    convenience init (name: String, attackpower: Int, hp: Int, type:String) {
        self.init(attackpower: attackpower, hp: hp, name: name)
        
        _type = type
        
    }
    
}

