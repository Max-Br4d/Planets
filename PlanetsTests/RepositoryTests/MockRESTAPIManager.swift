//
//  MockRestAPIManager.swift
//  PlanetsTests
//
//  Created by Max B. 17/04/2023.
//

import Foundation
@testable import Planets

class MockRestAPIManager: RestApiNetworkable {
    var path: String = ""
    func get(request: Requestable) async throws -> Data {
        do {
            let bundle = Bundle(for: MockRestAPIManager.self)
            guard !path.isEmpty, let resourcePath = bundle.url(forResource: path, withExtension: "json") else
            {
                throw RestApiCallError.apiError
            }
            let data = try Data(contentsOf: resourcePath)
            return data
        } catch {
            throw RestApiCallError.dataNotFound
        }
    }
}
