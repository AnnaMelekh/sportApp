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


    func performRequest(name: String? = nil,
                        type: String? = nil,
                        muscle: String? = nil,
                        difficulty: String? = nil,
                        completion: @escaping ([SportsModel]) -> Void
                    ) {
                        var components = URLComponents(string: "https://api.api-ninjas.com/v1/exercises")
                        var queryItems: [URLQueryItem] = []

                        if let name = name, !name.isEmpty {
                            queryItems.append(URLQueryItem(name: "name", value: name))
                        }
                        if let type = type, !type.isEmpty {
                            queryItems.append(URLQueryItem(name: "type", value: type))
                        }
                        if let muscle = muscle, !muscle.isEmpty {
                            queryItems.append(URLQueryItem(name: "muscle", value: muscle))
                        }
                        if let difficulty = difficulty, !difficulty.isEmpty {
                            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty))
                        }

                        components?.queryItems = queryItems

                        guard let url = components?.url else {
                            print("Invalid URL")
                            return
                        }
        
        var request = URLRequest(url: url)
        print(url)

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
            let decodedData = try decoder.decode([SportsModel].self, from: sportsData)
            return decodedData
        } catch {
            print("Ошибка декодирования: \(error)")
            return nil
        }
    }
}

