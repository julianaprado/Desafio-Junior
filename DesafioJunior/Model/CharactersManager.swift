//
//  CharactersManager.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import UIKit

/// Error enum
enum e: Error {
    case urlError
    case noData
    case parseError(e: Error)
}

/// CharactersManager
class CharactersManager {
    
    private var filtersString = ""
    var requestURL = ""
    var pageString = ""
    
    //Api string
    private let apiURL = "https://rickandmortyapi.com/api/"
    
    public var listOfCharacters = [CharactersData]()
    public var characters = [CharacterData]()
    public var loadedData = false
        
    //MARK: - Initializer
    init(searchFor: String){
        self.requestURL = "\(apiURL)\(searchFor)"
    }
    
    /// Get next page
    /// - Parameter page: specified page
    public func getNextPage(page: Int) {
        if filtersString != ""{
            let s = "&page=\(page)"
            self.requestURL = "\(apiURL)\(filtersString)\(s)"
            print(self.requestURL)
        }
        else {
            if pageString != ""{
                self.requestURL.removeLast(1)
                let s = "\(page)"
                self.requestURL += "\(s)"
            }
            else {
                let s = "?page=\(page)"
                self.requestURL += "\(s)"
                pageString = s
            }
        }
        print(requestURL)
    }
    
    /// Function parse JSON data
    /// - Parameter completion: Completion that returns a charactersData Array if success, or Error enum if failure
    private func getCharacters(completion: @escaping (Result<[CharactersData]?, e>) -> Void) {
        
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
    
    /// Function that sets the filter string
    /// - Parameter filters: string filters
    public func searchFor(filters: String){
        filtersString = filters
        self.requestURL = "\(apiURL)\(filters)"
    }
    
    /// Fetch characters
    public func fetchApi(){
        self.getCharacters{ [ weak self ] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    break
                case .success(let characters):
                    self?.listOfCharacters = characters!
                    self?.characters = characters![0].results
                    self?.loadedData = true
                }
            }
        }
    }
}

