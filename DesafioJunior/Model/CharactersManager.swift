//
//  CharactersManager.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import Foundation


enum e: Error {
    case urlError
    case noData
    case parseError(e: Error)
}

struct CharactersManager {
    
    var requestURL = ""
    var apiURL = "https://rickandmortyapi.com/api/"
    
    init(searchFor: String){
        self.requestURL = "\(apiURL)\(searchFor)"
    }
    
    func getCharacters(completion: @escaping (Result<[CharactersData]?, e>) -> Void) {
        
        // 1.Create a URL
        guard let url = URL(string: self.requestURL) else {
            completion(.failure(e.urlError))
            return
        }
        // 2. Create a URLSession
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let charactersData = data else{
                completion(.failure(e.noData))
                return
        }
            //3. Parse Data
            do {
                let decoder = JSONDecoder()
                let charactersResponse = try! decoder.decode(CharactersData.self, from: charactersData)
                completion(.success([charactersResponse]))
            }
        }
            // 4. Start the task
            dataTask.resume()
        }
}

