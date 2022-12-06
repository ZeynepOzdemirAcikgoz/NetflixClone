//
//  APICaller.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 6.12.2022.
//

import Foundation


struct Constants{
    
    static let API_KEY = "725732a1ed6b356f9e7828525690997a"
    static let baseURL = "https://api.themoviedb.org"
}


enum APIError: Error{
    
    case failedTogetData
}
class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error >) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
               // print(results.results[1].original_name)
                completion(.success(results.results))
                
            }catch {
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
            
        
        
        
        
    }
    
}
