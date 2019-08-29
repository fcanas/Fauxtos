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
    var pickerHeight: CGFloat = 0.5
}

struct AllPhotos: View {

    @EnvironmentObject var layout: SharedLayout

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

struct Header: View {

    static var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }

    var body: some View {
        Group {
            VStack {
                // ---!!!HACK!!!---
                // how do I make the background ignore safe insets, but subviews respect them again?
                // We want the gradient to extend to the edge of the screen. But then we want the
                // contained text to respect safe area insets.
                // Maybe the gradient should be in a ZStack?
                Spacer(minLength: 45)
                HStack {
                    // TODO: Make a model for photos that includes date
                    // information that can be displayed here.
                    Text("\(Header.formatter.string(from: Date()))")
                        .font(Font.largeTitle.bold())
                    Spacer()
                    Button(action: {
                        
                        print("hi")
                    }) {
                        Capsule()
                            .frame(height: 30)
                            .overlay(Text("Select")
                                .font(Font.callout.bold())
                                .foregroundColor(.white))
                            .foregroundColor(Color("PillButton", bundle: Bundle.init(for: SharedLayout.self)))
                    }
                }
                HStack{
                    // TODO: Make a model for photos that includes location
                    // information that can be displayed here.
                    Text("Hong Kong")
                        .font(Font.subheadline.bold())
                    Spacer()
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
    }

}
