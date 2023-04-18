//
//  PlanetViewModelTest.swift
//  PlanetsTests
//
//  Created by Max B. 17/04/2023.
//

import XCTest
@testable import Planets

final class PlanetViewModelTest: XCTestCase {
    
    var mockPlanetRepository: MockPlanetRepository!
    var planetViewModel: PlanetsViewModel!
    
    @MainActor override func setUp() {
        mockPlanetRepository = MockPlanetRepository()
        planetViewModel =  PlanetsViewModel(repository: mockPlanetRepository)
    }
    
    override func tearDown() {
        mockPlanetRepository = nil
        planetViewModel = nil
    }
    
    //when Planet list is not empty
    func testGetPlanetWhenListIsNotEmpty() async {
        
        // Given
        mockPlanetRepository.enqueuResponse(planets: Planet.mockPlanets())
    
        // When
        
        await planetViewModel.getPlanets()
        
        // Then
        let planets = await planetViewModel.planets
        XCTAssertEqual(planets.count, 2)
        XCTAssertEqual(planets.first?.name, "Tatooine")
        XCTAssertEqual(planets[1].name, "Alderaan")

        let viewState = await planetViewModel.viewState
        XCTAssertEqual(viewState, .loaded)
    }
    
    
    //when planet list is empty
    func testGetPlanetsWhenListIsEmpty() async {
        
        // Given
        mockPlanetRepository.enqueuResponse(planets:[])
    
        // When
        
        await planetViewModel.getPlanets()
        
        // Then
        let planets = await planetViewModel.planets
        XCTAssertEqual(planets.count, 0)
    
        let viewState = await planetViewModel.viewState
        XCTAssertEqual(viewState, .emptyView)
    }
    
    
    //when repository throws error for getPlanets
    func testGetPlanetsWhenRepositoryThrowsError() async {
        
        // Given
        mockPlanetRepository.enqueuError(error: RestApiCallError.apiError)
    
        // When
        await planetViewModel.getPlanets()
        
        // Then
        let planets = await planetViewModel.planets
        XCTAssertEqual(planets.count, 0)
    
        let viewState = await planetViewModel.viewState
        XCTAssertEqual(viewState, .error)
    }
}

