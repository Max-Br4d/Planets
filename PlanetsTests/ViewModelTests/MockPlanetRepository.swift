//
//  MockPlanetRepository.swift
//  PlanetsTests
//
//  Created by Max B. 17/04/2023.
//

import Foundation
@testable import Planets

class MockPlanetRepository: PlanetsRepositoryActions {
    
    private var planets: [Planet] = []
    private var error: RestApiCallError?

    func enqueuResponse(planets: [Planet]) {
        self.planets = planets
    }
    func enqueuError(error: RestApiCallError) {
        self.error = error
    }
    func getAllPlanets() async throws -> [Planets.Planet] {
        if error != nil {
            throw error!
        }
        return planets
    }
}
