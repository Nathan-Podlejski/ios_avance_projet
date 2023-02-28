//
//  Service.swift
//  IOS avance projet
//
//  Created by lpiem on 01/02/2023.
//

import Foundation

class Service {
    static let shared = Service()
    
    private init (){}
    
    func loadLandmarks() -> [Landmark] {
        do {
            let file = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
            let data = try Data(contentsOf: file)
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            return try jsonDecoder.decode([Landmark].self, from: data)
        }
        catch {
            fatalError("Cannot load data")
        }

    }
}
