//
//  ContentView.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 13/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var pokemon = [Pokemon]()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter( {
                    $0.name.contains(searchText.lowercased())
                })) { entry in
                    HStack {
                        PokemonImage(linkImage: "\(entry.url)")
                            .padding(.trailing, 20)
                        
                        NavigationLink("\(entry.name)".capitalized, destination: PokemonDetailView(pokemon: entry, pokemonInfo: SelectedPokemon.sampleData)
                        )
                    }
                }
            }
            .onAppear {
                PokemonAPI().getData { pokemon in
                    self.pokemon = pokemon
                    
                    for pokemon in pokemon {
                        print(pokemon.name)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokemon List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
