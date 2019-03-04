//
//  RecipesDetailsViewModel.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import UIKit

class RecipesDetailsViewModel {

    private let recipesClient: RecipesClient
    private let imageManager: ImageManager
    private let recipeId: Int

    init(recipesClient: RecipesClient, imageManager: ImageManager, recipeId: Int) {
        self.recipesClient = recipesClient
        self.imageManager = imageManager
        self.recipeId = recipeId
    }

    func getRecipeDetails(completion: @escaping (RecipeDetails?) -> Void) {
        recipesClient.getRecipeDetails(configuration: RecipesRouter.recipeDetails(id: recipeId)) { recipeDetails, _ in
            guard let recipeDetails = recipeDetails else {
                completion(nil)
                return
            }

            completion(recipeDetails)
        }
    }

    func getRecipeImage(recipeURL: URL, completion: @escaping (Data?) -> Void) {
        if let imageData = imageManager.getImage(url: recipeURL.absoluteString) {
            completion(imageData)
        } else {
            recipesClient.getProductImage(url: recipeURL) { [weak self] imageData in
                guard let strongSelf = self, let imageData = imageData else { return }
                strongSelf.imageManager.saveImage(url: recipeURL.absoluteString, imageData: imageData)
                completion(imageData)
            }
        }
    }
}
