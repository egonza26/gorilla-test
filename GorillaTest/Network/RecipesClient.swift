//
//  RecipesClient.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation

class RecipesClient: PerformRequestProtocol {

    static let shared = RecipesClient()
    private init() { }

    func getRecipies(configuration: APIConfiguration, completion: @escaping (_ result: [Recipe]?, _ error: Error?) -> Void) {
        performRequest(route: configuration, completion: completion)
    }

    func getRecipeDetails(configuration: APIConfiguration, completion: @escaping (_ result: RecipeDetails?, _ error: Error?) -> Void) {
        performRequest(route: configuration, completion: completion)
    }
}
