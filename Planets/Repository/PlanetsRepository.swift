//
//  PlanetsRepository.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

protocol PlanetsRepositoryActions {
    func getAllPlanets() async throws -> [Planet]
}

struct PlanetsRepository: JsonDecoder {
    private let serviceManager: RestApiNetworkable
    private let persisttence: PersistenceController

    init(serviceManager: RestApiNetworkable, persisttence: PersistenceController = .shared) {
        self.serviceManager = serviceManager
        self.persisttence =  persisttence
    }
}

extension PlanetsRepository: PlanetsRepositoryActions {
    
    /**
        getAllPlanets gets data from rest api call and parse it , if api calls fails reads data from locally stored core data, if api is success full persist response in core data
       @ Parameters:
       @ Returns:  List of Planets
     */
    func getAllPlanets() async throws -> [Planet] {
        let request = PlanetsRequest(path:  ApiEndPoints.planets)
        let data = try? await serviceManager.get(request:request)
        var planets: [Planet]?
        // Parsing json data received from api call
        if let data = data {
            planets = try? decode(data:data, to: PlanetResponse.self).results
        }
        
        if let planets = planets {
            // Save to core data
           try EPlanet.insertEPlanet(planets:planets , moc: persisttence.container.viewContext)
            return planets
        }else {
           // read from core data if api fails to return
           let ePlanets = EPlanet.fetchAllPlanets(moc: persisttence.container.viewContext)
            
            // Mapping core data entity to model (EPlanet to Planet)
            return ePlanets.map { $0.toPlanet() }
        }
    }
}
