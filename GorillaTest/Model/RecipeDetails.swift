//
//  RecipeDetails.swift
//  GorillaTest
//
//  Created by Ernesto Gonzalez on 3/3/19.
//  Copyright © 2019 Molekule. All rights reserved.
//

import Foundation

struct RecipeDetails: Decodable {
    var id: Int
    var title: String
    var rating: Int
    var image: URL
    var instructions: String
}
