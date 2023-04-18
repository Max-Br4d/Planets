//
//  RestApiManagerTests.swift
//  PlanetsTests
//
//  Created by Max B. 17/04/2023.
//

import XCTest
@testable import Planets

final class RestApiManagerTests: XCTestCase {
    
    var mockRestAPIManager: MockRestApiNetworking!
    var serviceManager: RestApiManager!
    
    @MainActor override func setUp() {
        mockRestAPIManager = MockRestApiNetworking()
        serviceManager = RestApiManager(urlSession: mockRestAPIManager)
    }
    
    override func tearDown() {
        mockRestAPIManager = nil
        serviceManager = nil
    }
    
    //when API is successful, get function will return expected data,
    
    func testGetPlanentsWhenResponseIs_200() async {
        
        // GIVEN
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 200, httpVersion:nil, headerFields:nil)
        
        // When
        let actualData = try! await serviceManager.get(request: PlanetsRequest(path:  ApiEndPoints.planets))
        
        // Then
        XCTAssertEqual(actualData, data)
    }
    
    //when API is fails with status code 404
    func testGetPlanetsWhenResponseIs_404() async {

        // Given
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 404, httpVersion:nil, headerFields:nil)
        
        do {
            _ = try await serviceManager.get(request: PlanetsRequest(path:  ApiEndPoints.planets))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidResponse)
        }
    }
    
    //when API is fails with status code other than 200 to 299 (Internal server error 502)
    
    func testGetPlanetsWhenResponseIs_502() async {
        
      // Given
         let data = "response".data(using: .utf8)
        mockRestAPIManager.mockData = data
        mockRestAPIManager.mockResponse = HTTPURLResponse(url:URL(string: "test")!, statusCode: 502, httpVersion:nil, headerFields:nil)
        
        do {
            _ = try await serviceManager.get(request: PlanetsRequest(path:  ApiEndPoints.planets))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidResponse)
        }
        
    }
    
    //when API is fails with request invalid
    func testPlanetsWhenRequestIsInValid() async {
        do {
            _ = try await serviceManager.get(request: PlanetsRequest(path:""))
        } catch {
            XCTAssertEqual(error as! RestApiCallError, RestApiCallError.invalidRequest)
        }
    }
}

