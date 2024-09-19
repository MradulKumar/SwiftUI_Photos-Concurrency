//
//  ContentView.swift
//  SwiftUI_Photos-Concurrency
//
//  Created by Mradul Kumar on 19/09/24.
//

import SwiftUI

struct CatalogView: View {
    @StateObject private var photos = Photos()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(photos.items) { item in
                        PhotoView(photo: item)
                    }
                    .listRowSeparator(.hidden)
                }
                .navigationTitle("Catalog")
                .listStyle(.plain)
            }
        }
        .task {
            await photos.updateItems()
        }
    }
}
