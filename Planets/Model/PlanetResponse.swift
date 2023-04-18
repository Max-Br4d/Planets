//
//  PlanetResponse.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

// MARK: - PlanetResponse
struct PlanetResponse: Decodable {
    let results: [Planet]
}

// MARK: - Planet
struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let created: String
    let edited: String
    let url: String
    let id = UUID()
}

extension Planet: Identifiable {}

extension Planet {
    /**
        Mocking Planet Objects for Preview and Testing
       @ Parameters:
       @ Returns:  list of Planets
     */
    static func mockPlanets() -> [Planet] {
        return [Planet(name:"Tatooine", rotationPeriod:"23", orbitalPeriod:"304", diameter:"", climate:"", gravity:"", terrain: "", surfaceWater: "", population:"", created:"", edited:"", url:""),
                Planet(name:"Alderaan", rotationPeriod:"23", orbitalPeriod:"304", diameter:"", climate:"", gravity:"", terrain: "", surfaceWater: "", population:"", created:"", edited:"", url:"")]
    }
}
