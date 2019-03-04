//
//  RecipesRouter.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation
import Alamofire

enum RecipesRouter: APIConfiguration {

    case recipes
    case recipeDetails(id: Int)

    var httpMethod: HTTPMethod {
        return .get
    }

    var requestPath: String {
        switch self {
        case .recipes:
            return "/recipes"
        case .recipeDetails(let id):
            return "/recipes/\(id)"
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var parameters: Parameters? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        return try buildRequest()
    }
}
