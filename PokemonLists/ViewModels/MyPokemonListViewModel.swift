//
//  MyPokemonListViewModel.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 14/04/23.
//

import Foundation

class MyPokemonListViewModel: ObservableObject {
    static let shared = MyPokemonListViewModel()
        
    @Published var myPokemons: [Pokemon] = []
    
    func save(pokemon: Pokemon) {
        myPokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        if let index = myPokemons.firstIndex(where: { $0.id == pokemon.id }) {
            myPokemons.remove(at: index)
        }
    }
}
