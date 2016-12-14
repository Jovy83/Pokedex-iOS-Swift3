//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by MacTesterSierra on 12/13/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    //MARK:- OUTLETS
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    //MARK:- PROPERTIES
    var pokemon: Pokemon!
    
    //MARK:- DEFAULT FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // these are parsed from the csv file
        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails(completed: { (success) in
            // whatever we write here will only be called after the network call is complete
            if success
            {
                // always update UI in the main thread.
                DispatchQueue.main.async {
                    self.updateUI()
                }
                
            }
            else
            {
                print("FAILED: TO PARSE JSON DATA")
            }
        })
    }
    
    //MARK:- MY FUNCTIONS
    func updateUI()
    {
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == ""
        {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        }
        else if !pokemon.isEvolutionLevelBased
        {
            evoLbl.text = "Pokemon has complex evolution/s that's not level based"
            nextEvoImg.isHidden = true
        }
        else
        {
            evoLbl.text = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
        }
    }
    
    //MARK:- ACTIONS
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    

    
}
