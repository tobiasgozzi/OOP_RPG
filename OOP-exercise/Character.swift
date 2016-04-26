//
//  Character.swift
//  OOP-exercise
//
//  Created by Tobias Gozzi on 18.04.16.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation

class Character {
    private var _hp = 100
    private var _attackpower = 15
    private var _name: String = ""
    
    var name:String {
        get {
            return _name
        }
    }

    var attackpower: Int {
        return _attackpower
    }
    
    var hp: Int {
        get {
            return _hp
        }
        set(newValue) {
            if newValue > 0 {
                _hp = newValue
            } else {
                _hp = 0
            }
        }
    }
    
    
    init(attackpower: Int, hp: Int, name: String) {
        _attackpower = attackpower
        _hp = hp
        _name = name
    }
    
    func attackingPlayer() {
        
    }
}