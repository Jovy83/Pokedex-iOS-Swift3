//
//  Pokemon.swift
//  Pokedex
//
//  Created by MacTesterSierra on 12/12/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _isEvolutionLevelBased: Bool
    private var _pokemonURL: String!
    
    
    //MARK:- GETTERS
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }

    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }

    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }

    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }

    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var isEvolutionLevelBased: Bool {
        return _isEvolutionLevelBased
    }

    
    //MARK:- INIT
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._isEvolutionLevelBased = true // set to true by default
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    //MARK:- FUNCTIONS
    func downloadPokemonDetails(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            var success = true
            if let dict = response.result.value as? Dictionary<String, Any>
            {
                // start parsing the data here
                // parse the weight
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                else
                {
                    print("FAILED: TO PARSE WEIGHT")
                    success = false
                }
                
                // parse the height
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                else
                {
                    print("FAILED: TO PARSE HEIGHT")
                    success = false
                }
                
                // parse the attack
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                else
                {
                    print("FAILED: TO PARSE ATTACK")
                    success = false
                }
                
                // parse the defense
                if let defense = dict["defense"] as? Int
                {
                    self._defense = "\(defense)"
                }
                else
                {
                    print("FAILED: TO PARSE DEFENSE")
                    success = false
                }
                
                // parse the type/s
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0
                {
                    for type in types
                    {
                        if let validType = type["name"]
                        {
                            if self._type != nil
                            {
                                // this means a previous type has already been stored, just append to it
                                self._type! += " / \(validType.capitalized)"
                            }
                            else
                            {
                                // no type has been stored yet, this is the first type entry.
                                self._type = validType.capitalized
                            }
                        }
                    }
                }
                else
                {
                    print("FAILED: TO PARSE TYPES")
                    success = false
                }
                
                // parse the description
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0
                {
                    // we're just going to use the first entry in the descriptionArray
                    if let url = descriptionArray[0]["resource_uri"]
                    {
                        let descriptionURL = "\(URL_BASE)\(url)"
                        
                        // fire off another request to retrieve the description from the given url
                        Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                            if let descriptionDict = response.result.value as? Dictionary<String, Any>
                            {
                                if let description = descriptionDict["description"] as? String
                                {
                                    // for some odd reason, the api is mispelling Pokemon with POKMON. we fix it below
                                    self._description = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                }
                                else
                                {
                                    print("FAILED: TO PARSE MAIN DESCRIPTION")
                                    success = false
                                }
                            }
                            
                            completed(success)
                        })
                        
                    }
                    else
                    {
                        print("FAILED: TO PARSE DESCRIPTION URL")
                        success = false
                    }
                }
                else
                {
                    print("FAILED: TO PARSE DESCRIPTION ARRAY")
                    success = false
                }
                
                // parse the evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0
                {
                    // parse the next evolve
                    if let nextEvo = evolutions[0]["to"] as? String
                    {
                        // exclude mega evolutions
                        if nextEvo.localizedStandardRange(of: "mega") == nil
                        {
                            // set the next evolve name
                            self._nextEvolutionName = nextEvo
                            
                            // parse the next evolve id
                            if let uri = evolutions[0]["resource_uri"] as? String
                            {
                                // resource_uri returns this format: /api/v1/pokemon/136/
                                // we only need the id at the end of it
                                let tempStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = tempStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                            }
                            else
                            {
                                print("FAILED: TO PARSE EVOLVE ID")
                                success = false
                            }
                            
                            // parse the next evolve level
                            if let lvlExist = evolutions[0]["level"]
                            {
                                if let lvl = lvlExist as? Int
                                {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                                else
                                {
                                    print("FAILED: TO PARSE EVOLVE LVL")
                                }
                            }
                            else
                            {
                                self._nextEvolutionLevel = ""
                                self._isEvolutionLevelBased = false
                                print("MESSAGE: EVOLUTION IS NOT LEVEL BASED")
                            }
                        }
                        else
                        {
                            print("MESSAGE: DISREGARDING MEGA EVOLUTION")
                        }
                    }
                }
                else
                {
                    print("MESSAGE: THERE'S NO EVOLUTIONS FOR THIS POKEMON")
                }
            }
            else
            {
                print("FAILED: TO GET JSON DATA")
                success = false
            }
            
            // call the completed here. we also call the completed one more time when the request to get the pokemon description is done
            completed(success)
        }
    }
}
