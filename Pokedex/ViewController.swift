//
//  ViewController.swift
//  Pokedex
//
//  Created by MacTesterSierra on 12/11/16.
//  Copyright © 2016 DIGIGAMES INTERACTIVE. All rights reserved.
//

import UIKit
import AVFoundation // needed for audio stuff

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupSearchBar()
        parsePokemonCSV()
        initAudio()
    }
    
    // MARK:- MY FUNCTIONS
    func setupCollectionView()
    {
        collection.delegate = self
        collection.dataSource = self
    }
    
    func setupSearchBar()
    {
        searchBar.delegate = self
        searchBar.returnKeyType = .done
    }
    
    func parsePokemonCSV()
    {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do
        {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows
            {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(pokemon)
            }
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
    
    func initAudio()
    {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 // loop continuously
            musicPlayer.play()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
    }

    //MARK:- COLLECTION VIEW DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // similar to cell for row for tableviews
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            let pokemon: Pokemon!
            if inSearchMode
            {
                pokemon = filteredPokemons[indexPath.row]
            }
            else
            {
                pokemon = pokemons[indexPath.row]
            }
            cell.configureCell(pokemon)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // called when an item in the collection is tapped
        
        view.endEditing(true) // dismiss the keyboard from the screen
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // the number of items
        if inSearchMode
        {
            return filteredPokemons.count

        }
        else
        {
            return pokemons.count

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // we set the size of the cell to the same size we set in the storyboard
        return CGSize(width: 105, height: 105)
    }
    
    //MARK: - SEARCHBAR DELEGATE METHODS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // called each time the text in the searchbar changes
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchMode = false
            view.endEditing(true) // dismiss the keyboard from the screen
        }
        else
        {
            inSearchMode = true
            
            //let lower = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({ (pokemon) -> Bool in
                //return pokemon.name.range(of: lower) != nil // if the name contains whatever is searched for, it is not nil and will return true. else, it returns false
                
                return pokemon.name.localizedStandardRange(of: searchBar.text!) != nil // this is apple's recommended way of using range. this is case and diacritic  insensitive, so we don't need to lowercase our search
            })
            // shorthand version. $0 basically refers the pokemons inside the array
            //filteredPokemons = pokemons.filter({$0.name.localizedStandardRange(of: lower) != nil})
        }
        
        // reload data afterwards
        collection.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) // dismiss the keyboard from the screen
    }

    //MARK: - ACTIONS
    @IBAction func btnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying
        {
            musicPlayer.pause()
            sender.alpha = 0.2 // make the button transparent if music paused
        }
        else
        {
            musicPlayer.play()
            sender.alpha = 1.0 // restore it back to 1.0 when playing
        }
    }
}

