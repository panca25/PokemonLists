//
//  PokemonDetailView.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 14/04/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon
    @State var pokemonInfo: SelectedPokemon
    @Environment(\.presentationMode) var presentationMode
    @State private var isAlertShown = false
    @State private var isNicknameAlertShown = false
    @State private var nickname = ""
    
    var body: some View {
        VStack {
            PokemonImage(linkImage: "\(pokemon.url)", frame: 200)
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Moves:")
                    .font(.headline)
                
                //                ForEach(pokemonInfo.moves) { move in
                //                    Text(move.move.name)
                //                }
                
                Text("Types:")
                    .font(.headline)
                
                ForEach(pokemonInfo.types) { type in
                    Text(type.type.name)
                }
            }
            .padding()
            
            Button("Catch Pokemon") {
                if Int.random(in: 0..<100) < 50 {
                    isNicknameAlertShown = true
                } else {
                    isAlertShown = true
                }
            }
            
            Spacer()
        }
        .alert(isPresented: $isAlertShown) {
            Alert(title: Text("Failed"), message: Text("Failed to catch Pokemon"))
        }
        .alert(isPresented: $isNicknameAlertShown) {
            Alert(title: Text("Congratulations!"), message: Text("You caught the Pokemon!"), primaryButton: .default(Text("OK")) {
                // add the caught pokemon to MyPokemonList
                MyPokemonListViewModel.shared.save(pokemon: pokemon)
            }, secondaryButton: .cancel(Text("Cancel")) {
                TextField("Nickname", text: $nickname)
            }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            SelectedPokemonAPI().getPokemonInfo(url: pokemon.url) { pokemonInfo in
                self.pokemonInfo = pokemonInfo
            }
        }
    }
}

private func addCaughtPokemon() {
    
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.sampleData[0], pokemonInfo: SelectedPokemon.sampleData)
    }
}
