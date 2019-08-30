//
//  ContentView.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/27/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

var layout: SharedLayout = SharedLayout()

/// Hosting View Controller for SwiftUI content.
/// This hasn't received a proper name because it has no real responsiblities beyond
/// things I believe should be handled from within SwiftUI. Everything is a hack.
public class HVC<Content>: UIHostingController<Content> where Content : View {

    override public var preferredStatusBarStyle: UIStatusBarStyle  { .lightContent }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ---!!!HACK!!!---
        // How can I get a SwiftUI ScrollView to scroll to the bottom?
        // Assume :
        //   1. it's rendered by a UIScrollView (it is)
        //   2. it's the only UIScrollView in the view hierarchy
        //   3. That its content size, etc. is set up and ready to go when the view appears
        //   4. Making the bottom of its content visible without animation happens immediately.
        // This awful.
        self.view.scrollViews().first?.scrollToBottom()
    }

}

public struct ContentView: View {
    @State private var selection = 0

    public init() { }

    public var body: some View {

        TabView(selection: $selection){
            
            AllPhotos()
                .environmentObject(layout)
                .font(.title)
                .tabItem {
                    VStack {
                        // TODO: This SFSymbol wants .fill, but it's been missing for the last few betas
                        Image(systemName: "photo.on.rectangle")
                            .font(Font.system(size: 22))
                        Text("All Photos")
                    }
            }
            .tag(0)

            Text("For You")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "suit.heart.fill")
                            .font(Font.system(size: 22))
                        Text("For You")
                    }
            }
            .tag(1)
            Text("Albums")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.stack.fill")
                            .font(Font.system(size: 22))
                        Text("Albums")
                    }
            }
            .tag(2)

            Text("Search")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(Font.system(size: 22))
                        Text("Search")
                    }
            }
            .tag(3)
        }.edgesIgnoringSafeArea(.top)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
