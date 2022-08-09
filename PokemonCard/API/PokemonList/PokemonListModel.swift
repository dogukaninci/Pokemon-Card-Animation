import Foundation

// MARK: - PokemonListModel
struct PokemonListModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonAPI]?
}

// MARK: - Result
struct PokemonAPI: Codable {
    let name: String?
    let url: String?
}


