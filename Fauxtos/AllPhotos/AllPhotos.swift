//
//  AllPhotos.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/27/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

class SharedLayout: ObservableObject {
    // Ideally, we'd be setting this and propagating it dynamically.
    var pickerHeight: CGFloat = 0.5
}

struct AllPhotos: View {

    @EnvironmentObject var layout: SharedLayout

    var body: some View {
        ZStack{
            PhotoList()
            VStack {
                Header().environment(\.colorScheme, .dark)
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
                Spacer(minLength: 45) // how do I make the background ignore safe insets, but subviews respect them again?
                HStack {
                    Text("\(Header.formatter.string(from: Date()))").font(Font.largeTitle.bold())
                    Spacer()
                    Button(action: {
                        
                        print("hi")
                    }) {
                        Capsule()
                            .frame(height: 30)
                            .overlay(Text("Select")
                                .font(Font.callout.bold())
                                .foregroundColor(.white))
                            .foregroundColor(Color("PillButton"))
                    }
                }
                //                .padding()
                HStack{
                    Text("Hong Kong").font(Font.subheadline.bold())
                    Spacer()
                }
                //                .padding()

            }
        }
        .edgesIgnoringSafeArea([])
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
    }

}
