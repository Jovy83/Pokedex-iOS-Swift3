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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
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
