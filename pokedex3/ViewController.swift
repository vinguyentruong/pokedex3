//
//  ViewController.swift
//  pokedex3
//
//  Created by Nguyen Truong Dai Vi on 6/22/17.
//  Copyright © 2017 Nguyen Truong Dai Vi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pokemons = [Pokemon]()
    private var filterPokemons = [Pokemon]()
    private var sound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.search
        parsePokemonCSV()
        filterPokemons = pokemons
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        do{
            sound = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            sound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func musicPressed(_ musicImage: UIButton){
        if sound.isPlaying {
            sound.stop()
            musicImage.alpha = 1
        }else {
            sound.play()
            musicImage.alpha = 0.5
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                pokemons.append(Pokemon(name: row["identifier"]!, id: Int(row["id"]!)!))
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = pokemons[indexPath.row]
        performSegue(withIdentifier: "pokemonDetail", sender: poke)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? pokeCell {
            cell.configuredCell(filterPokemons[indexPath.row])
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == ""){
            filterPokemons = pokemons
            collectionView.reloadData()
        }else {
            let lower = searchBar.text!.lowercased()
            filterPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetail" {
            if let pokeDetailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    pokeDetailVC.pokemon = poke
                }
            }
        }
    }
}

