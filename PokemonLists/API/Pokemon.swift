//
//  Pokemon.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 13/04/23.
//

import Foundation

struct PokemonList: Codable {
    var results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
    
    static let sampleData: [Pokemon] =
    [
        Pokemon(name: "bulbasar", url: "https://pokeapi.co/api/v2/pokemon/1/"),
        Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
        Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
    ]
}

class PokemonAPI {
    func getData(completion: @escaping ([Pokemon]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(PokemonList.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
