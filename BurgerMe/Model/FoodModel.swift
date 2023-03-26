//
//  FoodModel.swift
//  BurgerMe
//
//  Created by James Thang on 25/03/2023.
//

import SwiftUI

struct FoodModelData: Decodable {
    var data: [FoodModel]
}

struct FoodModel: Identifiable, Hashable, Decodable {
    var id: String
    var foodName: String
    var difficulty: String
    var imageUrl: String
    var position: Int
    var isHighlight: Bool? = false
}

enum FoodDifficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
