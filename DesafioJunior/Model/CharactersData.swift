//
//  CharactersData.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import Foundation

/// CharactersData
struct CharactersData: Codable {
    let info: Info
    var results: [CharacterData]
}

/// Info
struct Info: Codable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}

/// CharacterData
struct CharacterData: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: Origin
    public let location: Location
    public let image: String?
    public let episode: [String]
    public let url: String
    public let created: String
}

/// Origin
struct Origin: Codable{
    public let name: String
    public let url: String
}

/// Location
struct Location: Codable {
    public let name: String
    public let url: String
}

/// Episodes
struct Episodes: Codable{
    public let url: String
}
