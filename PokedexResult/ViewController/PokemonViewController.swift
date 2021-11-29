//
//  ViewController.swift
//  PokedexResult
//
//  Created by Jonathan Llewellyn on 11/16/21.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Methods
    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
        PokemonController.fetchSprite(pokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeIDLabel.text = String(pokemon.id)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchterm = searchBar.text,
              !searchterm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchTerm: searchterm) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
