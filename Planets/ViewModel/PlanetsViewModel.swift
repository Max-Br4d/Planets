//
//  PlanetsViewModel.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

protocol PlanetsViewModelType: ObservableObject {
    func getPlanets() async
}

// States for SwiftUI View
enum ViewStates {
    case loading
    case error
    case loaded
    case emptyView
}

@MainActor
final class PlanetsViewModel {
    @Published private(set) var viewState: ViewStates = .loaded
    private(set) var planets: [Planet] = []
    private let repository: PlanetsRepositoryActions
    init(repository: PlanetsRepositoryActions) {
        self.repository = repository
    }
}

extension PlanetsViewModel: PlanetsViewModelType {
    func getPlanets() async {
        viewState = .loading
        do {
            planets = try await repository.getAllPlanets()
            viewState =  planets.isEmpty ? .emptyView : .loaded
        } catch {
            self.viewState = .error
        }
    }
}
