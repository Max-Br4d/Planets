//  Request.swift
//  Planets
//
//  Created by .
//
import Foundation

protocol Requestable {
    var baseUrl: String {get}
    var path: String {get set}
    var params: [String: String] {get}
    var type: String {get}
    var header: [String: String] {get}
    func createUrlRequest() -> URLRequest?
}

extension Requestable {
    var baseUrl: String {
        return ApiEndPoints.baseUrl
    }
    var params: [String: String] {
        return [:]
    }
    var type: String {
        return ""
    }
    var header: [String: String] {
        return [:]
    }
    
    func createUrlRequest() -> URLRequest? {
        guard baseUrl.count > 0, path.count > 0 else { return nil }
        var urlComponnets = URLComponents(string: baseUrl + path)
        var queryItems: [URLQueryItem] = []
        for (key, value) in params {
            queryItems.append( URLQueryItem(name: key, value: value))
        }
        urlComponnets?.queryItems = queryItems
        guard let url = urlComponnets?.url else { return nil }
        return URLRequest(url: url)
    }
}

