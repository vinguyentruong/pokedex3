//
//  PokemonDetail.swift
//  pokedex3
//
//  Created by Nguyen Truong Dai Vi on 6/23/17.
//  Copyright © 2017 Nguyen Truong Dai Vi. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
 
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPokeDetail(complete: {
            self.updateUI()
        })
    }
    
    func downloadPokeDetail(complete: @escaping DownloadComplete){
        let url = URL(string: "\(URL_POKE_DETAIL)\(pokemon.id)/")
        Alamofire.request(url!).responseJSON(completionHandler: {
            response in
            
            if let result = response.value as? Dictionary<String, AnyObject>{
                let dict = JSON (dictionary: result)
                let height = dict["height"].stringValue
                let weight = dict["weight"].stringValue
                let defense = dict["defense"].stringValue
                let description = dict["descriptions"].stringValue
                let attack = dict["attack"].stringValue
                let types = dict["types"].arrayValue
                var typeFull = ""
                for type in types {
                    let dictType = JSON (dictionary: type)
                    typeFull += String(describing: dictType["name"]) + "/"
                }
                let evolutions = dict["evolutions"][0]["level"].stringValue
                self.pokemon.height = height
                self.pokemon.weight = weight
                self.pokemon.description = description
                self.pokemon.defense = defense
                self.pokemon.attack = attack
                self.pokemon.nextEvolution = evolutions
                self.pokemon.type = typeFull
            }
            complete()
        })
    }
    
    func updateUI(){
        typeLbl.text = pokemon.type
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        descriptionLbl.text = pokemon.description
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        evolutionLbl.text?.append(pokemon.nextEvolution)
        pokeImage.image = UIImage(named: "\(pokemon.id)")
        idLbl.text = "\(pokemon.id)"
    }
    
    @IBAction func backBtnPressed(_ button: UIButton){
        dismiss(animated: false, completion: nil)
    }
}
