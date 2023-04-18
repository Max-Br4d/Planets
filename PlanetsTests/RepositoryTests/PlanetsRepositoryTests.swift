//
//  PlanetsRepositoryTests.swift
//  PlanetsTests
//
//  Created by Max B. 17/04/2023.
//

import XCTest
@testable import Planets

final class PlanetsRepositoryTests: XCTestCase {
    
    var mockRestAPIManager: MockRestAPIManager!
    
    @MainActor override func setUp() {
        mockRestAPIManager = MockRestAPIManager()
    }
    
    override func tearDown() {
        mockRestAPIManager = nil
    }
    
    // when apiManager return success data
    func testWhenGeSchoolListSuccess() async {
        
        let planetsRepository = PlanetsRepository(serviceManager: mockRestAPIManager, persisttence: PersistenceController(inMemory: true))
        mockRestAPIManager.path = "PlanetsListResponseData"
        let lists = try! await planetsRepository.getAllPlanets()
        XCTAssertNotNil(lists)
        XCTAssertEqual(lists.count, 10)
    }
    
    //     when fails, planets list data is not nil but parsing fails due to key mismatching and data is not stored locally
    func testWhenGePlanetsListParsingFails() async throws {
        // GIVEN
        mockRestAPIManager.path = "PlanetsListResponseDataKeyMisMatch"
        
        let planetsRepository = PlanetsRepository(serviceManager: mockRestAPIManager, persisttence: PersistenceController(inMemory: true))
        
        let lists = try await planetsRepository.getAllPlanets()
        XCTAssertEqual(lists.count, 0)
    }
    
    //     when fails, planets list data is not nil but parsing fails due to key mismatching and data is stored locally
    func testWhenGePlanetsListFailsButDataIStoredLocaly() async throws {
        // GIVEN
        
        let planetsRepository = PlanetsRepository(serviceManager: mockRestAPIManager, persisttence: PersistenceController(inMemory: true))
        mockRestAPIManager.path = "PlanetsListResponseData"
        let _ = try! await planetsRepository.getAllPlanets()
        
        mockRestAPIManager.path = "PlanetsListResponseDataKeyMisMatch"
        let lists = try await planetsRepository.getAllPlanets()
        XCTAssertEqual(lists.count, 10)
    }
}

