//
//  Network.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import Foundation

class Network {
    static let shared = Network()
    
    enum Errors: Error, LocalizedError {
        case itemNotFound
        case urlNotFound
    }
    
    func fetchJSON(page: Int) async throws -> [Model] {
        let urlString = "https://pixabay.com/api/?key=38179042-713ab4e1956d39f7f30c39729&page=\(page)&per_page=20"
        let urlComponents = URLComponents(string: urlString)
        guard let url = urlComponents?.url else { throw Errors.urlNotFound}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else { throw Errors.itemNotFound }
        
        let jsonDecoder = JSONDecoder()
        let json = try jsonDecoder.decode(Hits.self, from: data)
       
        return json.hits
    }
}
