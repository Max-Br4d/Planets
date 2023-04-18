//
//  PlanetCellView.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import SwiftUI

struct PlanetCellView: View {
    let planet: Planet
    var body: some View {
        VStack(alignment: .leading){
            Text("\(planet.name)")
                .bold()
                .padding(.bottom, 0.5)
                .accessibilityIdentifier("planetName")
        }
    }
}

struct PlanetCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetCellView(planet: Planet.mockPlanets().first!)
    }
}
