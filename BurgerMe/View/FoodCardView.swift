//
//  FoodCardView.swift
//  BurgerMe
//
//  Created by James Thang on 24/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodCardView: View {
    
    var food: FoodModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AnimatedImage(url: URL(string: food.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.bottom)
                .padding(.bottom)
            
            Text(food.foodName)
                .foregroundColor(food.isHighlight ?? false ? .blue : .primary)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            Text(food.difficulty)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(food.isHighlight ?? false ? .blue : Color.black, lineWidth: 2)
                .padding(1)
        )
    }
}
