//
//  APIConfiguration.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var requestPath: String { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: Parameters? { get }
}

extension APIConfiguration {

    var baseURL: String {
        return "http://gl-endpoint.herokuapp.com"
    }

    func buildRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest: URLRequest!

        if let queryItems = queryItems, var urlComponents = URLComponents(string: url.absoluteString) {
            urlComponents.path = requestPath
            urlComponents.queryItems = queryItems
            urlRequest = URLRequest(url: try urlComponents.asURL())
        } else {
            urlRequest = URLRequest(url: url.appendingPathComponent(requestPath))
        }

        urlRequest.httpMethod = httpMethod.rawValue
    
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
