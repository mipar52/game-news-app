//
//  NetworkManager.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import Foundation

class NetworkManager {
    
   static let sharedInstance = NetworkManager()
    
    private init() {}
    
    private let baseUrl = "https://api.rawg.io/api/"
    
    func getGamesGenres() async throws -> Result <[Results]?, NetworkError> {
       let gamesUrl = baseUrl + "genres?key=\(K.rawgApiKey)"
        print(gamesUrl)
       print(gamesUrl)
       guard let url = URL(string: gamesUrl) else {
           throw NetworkError.badUrl(value: "Incorrect URL: \(gamesUrl)")
       }
       
       var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
       request.httpMethod = "GET"

       do {
           let (data, response) = try await URLSession.shared.data(for: request)
           let httpReponse = response as? HTTPURLResponse
           
           if let httpReponse = httpReponse {
               switch httpReponse.statusCode {
               case 200...299:
                   let result = try JSONDecoder().decode(GameGenre.self, from: data)
                   let gamesGenres = result.results
                   return .success(gamesGenres)
               case 400...499:
                   return .failure(NetworkError.badRequest)
               case 500...599:
                   return .failure(NetworkError.serverError)
               default:
                   return .failure(NetworkError.unknown)
               }
           }
       } catch {
           print(error)
           return .failure(NetworkError.decode(value: error.localizedDescription))
       }
        return .failure(NetworkError.unknown)
   }
    
    func getGamebyId(id: Int) async throws -> Result <Game?, NetworkError>  {
       let gamesUrl = baseUrl + "games/\(id)?key=\(K.rawgApiKey)"
       guard let url = URL(string: gamesUrl) else {
           throw NetworkError.badUrl(value: "Incorrect URL: \(gamesUrl)")
       }
       
       var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
       request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let httpReponse = response as? HTTPURLResponse
            
            if let httpReponse = httpReponse {
                switch httpReponse.statusCode {
                case 200...299:
                    let result = try JSONDecoder().decode(Game.self, from: data)
                    return .success(result)
                case 400...499:
                    return .failure(NetworkError.badRequest)
                case 500...599:
                    return .failure(NetworkError.serverError)
                default:
                    return .failure(NetworkError.unknown)
                }
            }
        } catch {
            print(error)
            return .failure(NetworkError.decode(value: error.localizedDescription))
        }
         return .failure(NetworkError.unknown)
    }
}
