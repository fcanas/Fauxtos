//
//  AllPhotos.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/27/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

class SharedLayout: ObservableObject {
    /// The height of the scope picker for the All Photos tab. Used to create
    /// a "content inset" for the photos view.
    /// ---!!!HACK!!!---
    /// Ideally, we'd be setting this and propagating it dynamically.
    /// Also, the height of 0.5 here is bizarre. The scrolling content's
    /// bottom jumps up above the picker view with seemingly _any_ positive
    /// value here. Values more than the picker height do push the photos
    /// up father. But values less than the height don't make the area too
    /// small.
    /// Maybe it would be even better to have this in a more locally-scoped
    /// environment object.
    @Published var pickerHeight: CGFloat = 0.5
    @Published var imagesPerRow: Int = 3
    @Published var imageGridSpacing: CGFloat = 2.0

}

struct AllPhotos: View {
    var body: some View {
        ZStack{
            PhotoList()
            VStack {
                Header()
                    .environment(\.colorScheme, .dark)
                Spacer()
                ScopePicker()
            }
        }
    }
}

