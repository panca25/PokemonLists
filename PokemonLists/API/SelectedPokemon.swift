//
//  SelectedPokemon.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 13/04/23.
//

import Foundation

struct SelectedPokemon: Codable {
    var sprites: PokemonSprites
    var name: String
    let moves: [Move]
    let types: [TypeElement]
    
    static let sampleData: SelectedPokemon =
        SelectedPokemon(sprites: PokemonSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), name: "bulbasaur", moves: [Move(move: Species(name: "razor-wind", url: "https://pokeapi.co/api/v2/move/13/"))], types: [TypeElement(slot: 1, type: Species(name: "grass", url: "https://pokeapi.co/api/v2/type/12/"))])
}

struct PokemonSprites: Codable {
    var front_default: String?
}

// MARK: - Move
struct Move: Codable, Identifiable {
    let id = UUID()
    let move: Species

    enum CodingKeys: String, CodingKey {
        case move
    }
}

// MARK: - TypeElement
struct TypeElement: Codable, Identifiable {
    let id = UUID()
    let slot: Int
    let type: Species
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}


class SelectedPokemonAPI {
//    func getPokemonImage(url: String, completion: @escaping (PokemonSprites) -> ()) {
//        guard let url = URL(string: url) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//
//            let pokemonSprites = try! JSONDecoder().decode(SelectedPokemon.self, from: data)
//
//            DispatchQueue.main.async {
//                completion(pokemonSprites.sprites)
//            }
//        }.resume()
//    }
    
    func getPokemonInfo(url: String, completion: @escaping (SelectedPokemon) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let pokemonInfo = try! JSONDecoder().decode(SelectedPokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonInfo)
            }
        }
        .resume()
    }
}
