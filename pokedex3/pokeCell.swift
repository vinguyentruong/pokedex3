//
//  pokeCellCollectionViewCell.swift
//  pokedex3
//
//  Created by Nguyen Truong Dai Vi on 6/22/17.
//  Copyright © 2017 Nguyen Truong Dai Vi. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    
    func configuredCell(_ pokemon: Pokemon){
        self.nameLbl.text = pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(pokemon.id)")
    }
    
}
