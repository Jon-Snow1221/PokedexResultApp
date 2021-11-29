//
//  PokemonError.swift
//  PokedexResult
//
//  Created by Jonathan Llewellyn on 11/16/21.
//

import Foundation

enum PokemonError: LocalizedError {
    
    //What we see as developers:
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    // What the user sees:
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "Unable to reach PokeAPI.co"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
