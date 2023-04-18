//
//  PlanetDetailsView.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import SwiftUI

struct PlanetDetailsView: View {
    let planet: Planet
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(planet.name)").bold()
                Text("Rotation period: \(planet.rotationPeriod)")
                Text("Orbital period: \(planet.orbitalPeriod)")
                Text("Diameter: \(planet.diameter)")
                Text("Climate: \(planet.climate)")
                Text("Gravity: \(planet.gravity)")
                Text("Terrain: \(planet.terrain)")
                Text("Surface water: \(planet.surfaceWater)")
                Text("Population: \(planet.population)")
                Spacer()
            }
            Spacer()
        }
        .padding()
        .navigationTitle(planet.name)
    }
}

struct PlanetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailsView(planet: Planet.mockPlanets().first!)
    }
}
