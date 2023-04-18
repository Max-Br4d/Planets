//
//  PlanetsApp.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import SwiftUI

@main
struct PlanetsApp: App {
    var body: some Scene {
        WindowGroup {
            PlanetsListView(viewModel: PlanetsViewModel(repository: PlanetsRepository(serviceManager: RestApiManager())))
        }
    }
}
