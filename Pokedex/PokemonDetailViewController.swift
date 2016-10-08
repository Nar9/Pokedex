//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Narine Balasanyan on 10/6/16.
//  Copyright © 2016 Narine Balasanyan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var currentEvolutionImageConstraint: NSLayoutConstraint!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvolutionImage.image = image
        
        pokemon.downloadPokemonDetails { () -> () in
            //this will be called after download is done
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defence
        heightLabel.text = pokemon.height
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = "\(pokemon.weight)"
        attackLabel.text = pokemon.attack
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImage.isHidden = true
            currentEvolutionImageConstraint.constant = 0
        } else {
            nextEvolutionImage.isHidden = false
            let constraint = self.view.frame.width / 2 - 80
            currentEvolutionImageConstraint.constant = currentEvolutionImageConstraint.constant - constraint
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            var string = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" {
                string += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evolutionLabel.text = string
        }
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
