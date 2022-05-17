import Foundation
struct DetailService  {
    func fetchData(url: String, completion:@escaping (PokemonDetailModel) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
                completion(pokemonDetail)
            }catch {
                print(error)
            }
            
        }.resume()
    }
}
