import Foundation
struct ListService  {
    func fetchData(completion:@escaping ([PokemonAPI]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1126") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(PokemonListModel.self, from: data)
            
            completion(pokemonList.results ?? [])
        }.resume()
    }
}
