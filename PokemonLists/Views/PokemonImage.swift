//
//  PokemonImage.swift
//  PokemonLists
//
//  Created by Panca Setiawan on 14/04/23.
//

import SwiftUI

let imagePlaceholder = "https://cdn.icon-icons.com/icons2/2603/PNG/512/poke_ball_icon_155925.png"

struct PokemonImage: View {
    var linkImage = ""
    var frame = CGFloat(75)
    @State private var pokemonSprite = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: frame, height: frame)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: linkImage)
                
                if loadedData == nil {
                    getSprite(url: linkImage)
                    UserDefaults.standard.set(linkImage, forKey: linkImage)
                    //print("New URL! Caching...")
                } else {
                    getSprite(url: loadedData!)
                    //print("Using cached url.")
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.80))
    }
    
    func getSprite(url: String) {
        var tempSprite: String? //Barangkali linknya nil, maka dibuat optional
        
        SelectedPokemonAPI().getPokemonInfo(url: url) { pokemonInfo in
            tempSprite = pokemonInfo.sprites.front_default
            
            self.pokemonSprite = tempSprite ?? imagePlaceholder
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
