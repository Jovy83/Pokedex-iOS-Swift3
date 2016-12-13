//
//  PokeCell.swift
//  Pokedex
//
//  Created by Jovy Ong on 12/12/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //MARK: PROPERTIES
    var pokemon: Pokemon!
    
    //MARK: METHODS
    // You can either use awakeFromNib or required init? for the initialization of this cell
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }

//    override func awakeFromNib() {
//        layer.cornerRadius = 5.0
//    }
    
    func configureCell(_ pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
