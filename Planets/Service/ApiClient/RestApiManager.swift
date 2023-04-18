//
//  RESTAPIManager.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

struct RestApiManager {
    private let urlSession: RestApiNetworking
    init(urlSession: RestApiNetworking = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension RestApiManager: RestApiNetworkable {
    /**
        This function will do rest api call using URLSesson with Async await
       @ Parameters: Api Request object of type Requestable
       @ Returns:  Data received from API Call or throws error if    api call fails 
     */
    func get(request: Requestable) async throws -> Data {
        // creating valid url request from Request object
        guard let urlRequest = request.createUrlRequest() else {
            throw RestApiCallError.invalidRequest
        }
        // Calling API using URLSession
        let (data, response) = try await urlSession.data(for: urlRequest, delegate: nil)
        // Validating response
        if  response.isValidResponse() {
            return data
        } else {
            throw RestApiCallError.invalidResponse
        }
    }
}

extension URLResponse {
    func isValidResponse()-> Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }
        switch response.statusCode {
        case 200...299:
          return true
        default:
          return false
        }
    }
}
