//
//  MyPokemonView.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 14/04/23.
//

import SwiftUI

struct MyPokemonView: View {
    @ObservedObject var viewModel = MyPokemonListViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? viewModel.myPokemons : viewModel.myPokemons.filter( {
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
            .searchable(text: $searchText)
            .navigationTitle("Pokemon List")
        }
    }
}

struct MyPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        MyPokemonView(viewModel: MyPokemonListViewModel())
    }
}
