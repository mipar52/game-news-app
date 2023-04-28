//
//  NetworkManager.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import Foundation

struct NetworkManager {
    
   static let sharedInstance = NetworkManager()
    private let baseUrl = "https://api.rawg.io/api/"
    
     func getGames() async throws -> GameList? {
        let gamesUrl = baseUrl + "games?key=\(K.rawgApiKey)&dates=2019-09-01,2019-09-30&platforms=18,1,7"
        print(gamesUrl)
        guard let url = URL(string: gamesUrl) else {
            throw NetworkError.badUrl(value: "Incorrect URL: \(gamesUrl)")
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
           // print("Reponse: \(response.description)")
            let result = try JSONDecoder().decode(GameList.self, from: data)
            let games = result.results
            let highestRatedGames = result.results.sorted { gameOne, gameTwo in
                return gameOne.rating > gameTwo.rating
            }
            for highestRatedGame in highestRatedGames {
                print(highestRatedGame.name, highestRatedGame.genres[0].name ,highestRatedGame.rating)
            }

            return result
            //print(result.results)
            
        } catch {
            print(error)
        }
         return nil
    }
    
    func getGamesGenres() async throws -> [Results?] {
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
          // print("Reponse: \(response.description)")
           let result = try JSONDecoder().decode(GameGenre.self, from: data)
           let gamesGenres = result.results
           return gamesGenres
       } catch {
           print(error)
           return []
       }
   }
    
    func getGamebyId(id: Int) async throws -> Game? {
       let gamesUrl = baseUrl + "games/\(id)?key=\(K.rawgApiKey)"
        print(gamesUrl)
       print(gamesUrl)
       guard let url = URL(string: gamesUrl) else {
           throw NetworkError.badUrl(value: "Incorrect URL: \(gamesUrl)")
       }
       
       var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
       request.httpMethod = "GET"
       
       do {
           let (data, response) = try await URLSession.shared.data(for: request)
          // print("Reponse: \(response.description)")
           let result = try JSONDecoder().decode(Game.self, from: data)
           print(result.name_original)
           print(result.developers)
           print(result.reddit_name)
           //print(result.results)
           return result
       } catch {
           print(error)
           return nil
       }
   }

}
