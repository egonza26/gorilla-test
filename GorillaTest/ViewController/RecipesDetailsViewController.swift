//
//  RecipesDetailsViewController.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import UIKit

class RecipesDetailsViewController: UIViewController {

    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var raitingStackView: UIStackView!
    @IBOutlet var recipeInfo: UILabel!

    var recipeId: Int!
    private var viewModel: RecipesDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    private func initialSetup() {
        viewModel = RecipesDetailsViewModel(recipesClient: RecipesClient.shared, imageManager: ImageManager.shared, recipeId: recipeId)
        getRecipeDetails()
    }

    private func getRecipeDetails() {
        viewModel.getRecipeDetails { [weak self] recipe in
            guard let strongSelf = self, let recipe = recipe else { return }
            strongSelf.configureView(recipe)
        }
    }

    private func configureView(_ recipe: RecipeDetails) {
        title = recipe.title
        recipeInfo.text = recipe.instructions
        configureRaiting(recipe.rating)
        configureRecipeImage(recipeURL: recipe.image)
    }

    private func configureRaiting(_ rating: Int) {
        for (index, view) in raitingStackView.subviews.enumerated() {
            (view as? UIImageView)?.image = index <= rating ? #imageLiteral(resourceName: "fill_star") : #imageLiteral(resourceName: "unfilled_star")
        }
    }

    private func configureRecipeImage(recipeURL: URL) {
        viewModel.getRecipeImage(recipeURL: recipeURL) { [weak self] imageData in
            guard let strongSelf = self, let imageData = imageData else { return }
            strongSelf.recipeImage.image = UIImage(data: imageData)
        }
    }
}
