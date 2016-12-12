//
//  ViewController.swift
//  Pokedex
//
//  Created by MacTesterSierra on 12/11/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
    }
    
    // MARK: MY FUNCTIONS
    func setupCollectionView()
    {
        collection.delegate = self
        collection.dataSource = self
    }

    //MARK: COLLECTION VIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // similar to cell for row for tableviews
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            //cell.configureCell(pokemon: <#T##Pokemon#>)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // called when an item in the collection is tapped
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // the number of items
        return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // we set the size of the cell to the same size we set in the storyboard
        return CGSize(width: 105, height: 105)
    }

}

