//
//  Home.swift
//  BurgerMe
//
//  Created by James Thang on 24/03/2023.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var viewModel = FoodViewModel()
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible()),
    ]
    @State private var showingFilters = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Trending Recipes")
                        .frame(alignment: .leading)
                        .font(.largeTitle.bold())
                                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.foodData, id: \.self) { food in
                            FoodCardView(food: food)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
            .padding()
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(Text("Recipes"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter") {
                        showingFilters = true
                    }
                    .actionSheet(isPresented: $showingFilters) {
                        ActionSheet(
                            title: Text("Difficulty"), message: Text("You can filter recipes by difficulty"),
                            buttons: [
                                .default(Text(FoodDifficulty.easy.rawValue)) {
                                    withAnimation {
                                        viewModel.filterByDifficulty(difficulty: .easy)
                                    }
                                },
                                .default(Text(FoodDifficulty.medium.rawValue)) {
                                    withAnimation {
                                        viewModel.filterByDifficulty(difficulty: .medium)
                                    }
                                },
                                .default(Text(FoodDifficulty.hard.rawValue)) {
                                    withAnimation {
                                        viewModel.filterByDifficulty(difficulty: .hard)
                                    }
                                },
                                .cancel(Text("Cancel"), action: {
                                    withAnimation {
                                        viewModel.cancelFilter()
                                    }
                                })
                            ]
                        )
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

