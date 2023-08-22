//
//  NetworkManager.swift
//  bankey
//
//  Created by huseyin on 22.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(responseType, from: data)
    }
}
