//
//  FoodViewModel.swift
//  BurgerMe
//
//  Created by James Thang on 25/03/2023.
//

import SwiftUI

class FoodViewModel: ObservableObject {
    
    @Published private(set) var foodData: [FoodModel] = []
    
    init() {
        do {
            let jsonData: FoodModelData = try loadJSONFromDisk("food_data.json")
            foodData = jsonData.data.sorted(by: { $0.position < $1.position })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filterByDifficulty(difficulty: FoodDifficulty) {
        var highlightedRecipe: [FoodModel] = []
        var notHighlightedRecipe: [FoodModel] = []
        
        for (index, recipe) in foodData.enumerated() {
            if FoodDifficulty(rawValue: recipe.difficulty ) == difficulty {
                foodData[index].isHighlight = true
                highlightedRecipe.append(foodData[index])
            } else {
                foodData[index].isHighlight = false
                notHighlightedRecipe.append(foodData[index])
            }
        }
        
        highlightedRecipe.sort(by: { $0.position < $1.position })
        notHighlightedRecipe.sort(by: { $0.position < $1.position })
        foodData.removeAll()
        foodData.append(contentsOf: highlightedRecipe)
        foodData.append(contentsOf: notHighlightedRecipe)
    }
    
    func cancelFilter() {
        for (index, _) in foodData.enumerated() {
            foodData[index].isHighlight = false
        }
        foodData.sort(by: { $0.position < $1.position })
    }
    
    private func loadJSONFromDisk<T: Decodable>(_ filename: String) throws -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
            throw LoadJsonError.CannotFind
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            throw LoadJsonError.CannotLoad
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw LoadJsonError.CannotParse
        }
    }
 
}
