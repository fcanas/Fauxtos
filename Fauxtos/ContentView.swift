//
//  ContentView.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/27/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0

    var body: some View {

        TabView(selection: $selection){
            
            AllPhotos()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "photo.on.rectangle").font(Font.system(size: 22)) // wants .fill
                        Text("All Photos")
                    }
            }
            .tag(0)

            Text("For You")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "suit.heart.fill").font(Font.system(size: 22))
                        Text("For You")
                    }
            }
            .tag(1)
            Text("Albums")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.stack.fill").font(Font.system(size: 22))
                        Text("Albums")
                    }
            }
            .tag(2)

            Text("Search")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass").font(Font.system(size: 22))
                        Text("Search")
                    }
            }
            .tag(3)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
