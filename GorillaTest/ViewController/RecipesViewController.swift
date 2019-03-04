//
//  RecipesViewController.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet var recipesTableView: UITableView!

    private var searchController: UISearchController!
    private var viewModel: RecipesViewModel!
    private var filterRecipes: [Recipe]!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    private func initialSetup() {
        configuraNavigationController()
        configureSearchController()
        viewModel = RecipesViewModel(recipesClient: RecipesClient.shared)
        filterRecipes = []
        getRecipes()
    }

    private func configuraNavigationController() {
        title = "Recipes"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func getRecipes() {
        viewModel.getRecipes { [weak self] completed in
            guard let strongSelf = self, completed else { return }
            strongSelf.filterRecipes = strongSelf.viewModel.dataSource
            strongSelf.recipesTableView.reloadData()
        }
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterRecipes = viewModel.dataSource.filter({ recipe -> Bool in
            return recipe.title.lowercased().contains(searchText.lowercased())
        })

        recipesTableView.reloadData()
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? RecipesDetailsViewController, let id = sender as? Int else { return }
        viewController.recipeId = id
    }
}

extension RecipesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filterRecipes.count : viewModel?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = isFiltering() ? filterRecipes[indexPath.row].title : viewModel.dataSource[indexPath.row].title
        cell.textLabel?.textColor = UIColor.darkGray
        return cell
    }
}

extension RecipesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RecipeDetailsSegue", sender: viewModel.dataSource[indexPath.row].id)
    }
}

extension RecipesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }
}

