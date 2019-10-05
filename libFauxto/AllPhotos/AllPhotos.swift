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
    /// Maybe it would be even better to have this in a more locally-scoped
    /// environment object.
    @Published var pickerHeight: CGFloat = 55.0
    @Published var imagesPerRow: Int = 3
    @Published var imageGridSpacing: CGFloat = 2.0

    @Published var selecting: Bool = false
}

struct AllPhotos: View {
    @EnvironmentObject var layout: SharedLayout
    var body: some View {
        ZStack{
            PhotoList()
            VStack {
                Header()
                Spacer()
                if !self.layout.selecting {
                    ScopePicker()
                }
            }
        }
    }
}

