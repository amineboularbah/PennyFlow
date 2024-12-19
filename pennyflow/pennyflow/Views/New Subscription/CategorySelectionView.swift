//
//  CategorySelectionView.swift
//  pennyflow
//
//  Created by Amine on 18/12/2024.
//
import SwiftUI

struct CategorySelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCategory: Category?

    @Environment(\.managedObjectContext) var context
    @State private var categories: [Category] = []

    var body: some View {
        NavigationView {
            List(categories, id: \.self) { category in
                HStack {
                    Text(category.name ?? "Unknown")
                    Spacer()
                    if selectedCategory == category {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCategory = category
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Select Category")
            .onAppear(perform: loadCategories)
        }
    }

    private func loadCategories() {
        print("Load categories is not implemented yet")
      /*  let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
        }*/
    }
}
