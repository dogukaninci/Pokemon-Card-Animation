import Foundation

final class PokemonViewModel {
    private let pokemonListService: ListService
    private let pokemonDetailService: DetailService
    
    var pokemonListWithDetails = [Pokemon]()
    
    init() {
        pokemonListService = ListService()
        pokemonDetailService = DetailService()
    }
    func fetchItems(completion:@escaping () -> ()) {
        let group = DispatchGroup()
        
        pokemonListService.fetchData { results in
            results.forEach { item in
                group.enter()
                if let url = item.url {
                    self.pokemonDetailService.fetchData(url: url) { detail in
                        if let pokemonName = item.name {
                            let pokemon = Pokemon(name: pokemonName, detail: detail)
                            self.pokemonListWithDetails.append(pokemon)
                            group.leave()
                        }
                    }
                }
            }
            group.notify(queue: .main) {
                completion()
            }
        }
    }
}
