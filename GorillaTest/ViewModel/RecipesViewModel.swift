//
//  RecipesViewModel.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import UIKit

class RecipesViewModel {

    private let recipesClient: RecipesClient
    private(set) var dataSource: [Recipe]

    init(recipesClient: RecipesClient) {
        self.recipesClient = recipesClient
        self.dataSource = []
    }

    func getRecipes(completion: @escaping (Bool) -> Void) {
        recipesClient.getRecipies(configuration: RecipesRouter.recipes) { [weak self] recipes, _ in
            guard let strongSelf = self, let recipes = recipes else {
                completion(false)
                return
            }

            strongSelf.dataSource = recipes
            completion(true)
        }
    }
}
