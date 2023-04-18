//
//  RESTAPIError.swift
//  Planets
//
//  Created by Max B. 17/04/2023.
//

import Foundation

enum RestApiCallError:Error {
    case invalidRequest
    case apiError
    case dataNotFound
    case responseError
    case parsingError
    case invalidResponse
}


