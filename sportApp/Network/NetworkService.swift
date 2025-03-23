//
//  NetworkService.swift
//  sportApp
//
//  Created by Anna Melekhina on 21.03.2025.
//

import UIKit


protocol NetworkServiceDelegate {
    func didUpdateData(sports: [SportsModel])
    func didFailWithError(error: Error)
}

struct NetworkService {
    
    
    var delegate: NetworkServiceDelegate?


    func performRequest(name: String? = nil, ingredient: String? = nil, completion: @escaping ([SportsModel]) -> Void) {
        var components = URLComponents(string: "https://api.api-ninjas.com/v1/cocktail")
           var queryItems: [URLQueryItem] = []
           
           if let name = name, !name.isEmpty {
               queryItems.append(URLQueryItem(name: "name", value: name))
           } else if let ingredient = ingredient, !ingredient.isEmpty {
               queryItems.append(URLQueryItem(name: "ingredients", value: ingredient))
           }
           
           components?.queryItems = queryItems
           
           guard let url = components?.url else {
               print("Invalid URL")
               return
           }
        
        var request = URLRequest(url: url)

        request.setValue("37dzcC9ewolb+jdrMMi3ZQ==rm21imKoXto6vJJd", forHTTPHeaderField: "X-Api-Key")
        let session = URLSession(configuration: .default)
            
             let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Ошибка запроса: \(error.localizedDescription)")
                    return
                }
                
                if let safeData = data {
                    if let sportsModel = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateData(sports: sportsModel)
                        }
                    }
                }
            }
            
             task.resume()
        }
    
    
    func parseJSON(_ sportsData: Data) -> [SportsModel]? {
        let decoder = JSONDecoder()
        
        do {
                let decodedData = try decoder.decode([SportsData].self, from: sportsData)
                
                let sportsArray = decodedData.map { sport in
                    SportsModel(
                        name: sport.name,
                        type: sport.type,
                        muscle: sport.muscle,
                        equipment: sport.equipment,
                        difficulty: sport.difficulty,
                        instructions: sport.instructions
                    )
                }
                
                print(sportsArray)
                return sportsArray
            
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
}

