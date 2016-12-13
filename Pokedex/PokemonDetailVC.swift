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
        
        nameLbl.text = pokemon.name

    }
    
    //MARK:- MY FUNCTIONS
    
    //MARK:- ACTIONS
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    

    
}
