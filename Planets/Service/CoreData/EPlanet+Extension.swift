//
//  EPlanet+Extension.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation
import CoreData

extension EPlanet {
    
   
    /**
       Insert Planets to core data entity EPlanet,
       @ Parameters:
            list of planets [Planet]
            managed object context :NSManagedObjectContext
       @ Returns: throws error if fails to save in core data
     */
    static func insertEPlanet(planets: [Planet], moc: NSManagedObjectContext)throws {
        
        // First delete all records than save all records to avoid duplication.
        try deleteRecords(moc: moc)
        planets.forEach { planet in
            let ePlanet = NSEntityDescription.insertNewObject(forEntityName:"EPlanet", into: moc) as? EPlanet
            
            ePlanet?.name = planet.name
            ePlanet?.rotationPeriod = planet.rotationPeriod
            ePlanet?.orbitalPeriod = planet.orbitalPeriod
            ePlanet?.diameter = planet.diameter
            ePlanet?.gravity = planet.gravity
            ePlanet?.climate = planet.climate
            ePlanet?.terrain = planet.terrain
            ePlanet?.surfaceWater = planet.surfaceWater
            ePlanet?.created = planet.created
            ePlanet?.edited = planet.edited
            ePlanet?.url = planet.url
        }
        try moc.save()
    }
    
    /**
        fetch all planets from core data
       @ Parameters:
            managed object context :NSManagedObjectContext
       @ Returns: list of EPlanets
     */
    static func fetchAllPlanets(moc: NSManagedObjectContext)-> [EPlanet] {
        let fr = EPlanet.fetchRequest()
        return (try? moc.fetch(fr)) ?? []
    }
    
    /**
        Deletes all planets from core data
       @ Parameters:
            managed object context :NSManagedObjectContext
       @ Returns: throws error if fails to delete record
     */
    static func deleteRecords(moc: NSManagedObjectContext)throws {
       let planets =  EPlanet.fetchAllPlanets(moc: moc)
        
        planets.forEach {
            moc.delete($0)
        }
        try moc.save()
    }
    
    /**
        Mapping Core Data EPlanet entity to Planet Model
       @ Parameters:
       @ Returns:  Planet Object
     */
    func toPlanet()-> Planet {
        return Planet(name:name ?? "",
                      rotationPeriod: rotationPeriod ?? "", orbitalPeriod: orbitalPeriod ?? "", diameter: diameter ?? "",
                      climate: climate ?? "", gravity: gravity ?? "",
                      terrain: terrain ?? "", surfaceWater: surfaceWater ?? "", population: population ?? "", created: created ?? "", edited: edited ?? "", url: url ?? "")
    }
}
