//
//  RESTAPINetworkable.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

protocol RestApiNetworkable {
    func get(request: Requestable) async throws -> Data
}

