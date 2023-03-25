//
//  FoodViewModel.swift
//  BurgerMe
//
//  Created by James Thang on 25/03/2023.
//

import SwiftUI

class FoodViewModel: ObservableObject {
    
    private(set) var foodOriginalData: [FoodModel] = []
    @Published private(set) var foodData: [FoodModel] = []
    
    init() {
        do {
            let jsonData: FoodModelData = try loadJSONFromDisk("food_data.json")
            foodOriginalData = jsonData.data
            foodData = foodOriginalData.sorted(by: { $0.position < $1.position })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filterByDifficulty(difficulty: FoodDifficulty) {
        foodData = foodOriginalData.filter({ FoodDifficulty(rawValue: $0.difficulty) == difficulty }).sorted(by: { $0.position < $1.position })
    }
    
    func cancelFilter() {
        foodData = foodOriginalData.sorted(by: { $0.position < $1.position })
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
