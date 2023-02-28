//
//  Landmark.swift
//  IOS avance projet
//
//  Created by lpiem on 01/02/2023.
//

import UIKit
import Foundation
import CoreLocation

struct Landmark: Decodable, Hashable {
    
    let name: String
    let category: Category
    let city, state: String
    let id: Int
    let isFeatured, isFavorite: Bool
    let park: String
    let coordinates: Coordinates
    let description, imageName: String
    let date: Date
    
    enum Category: String, Decodable, Hashable, CaseIterable {
        case lakes = "Lakes"
        case mountains = "Mountains"
        case rivers = "Rivers"
    }

    // MARK: - Coordinates
    struct Coordinates: Decodable, Hashable {
        let longitude, latitude: Double
    }

    var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
}



