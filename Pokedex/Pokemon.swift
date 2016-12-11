//
//  Pokemon.swift
//  Pokedex
//
//  Created by MacTesterSierra on 12/12/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import Foundation

class Pokemon {
    
    //MARK:- PROPERTIES
    private var _name: String!
    private var _pokedexId: Int!
    
    //MARK:- GETTERS
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    //MARK:- INIT
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
