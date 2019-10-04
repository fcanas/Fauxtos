//
//  Header.swift
//  libFauxto
//
//  Created by Fabián Cañas on 8/30/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

struct Header: View {

    static var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }

    var body: some View {
            VStack {
                // ---!!!HACK!!!---
                // how do I make the background ignore safe insets, but subviews respect them again?
                // We want the gradient to extend to the edge of the screen. But then we want the
                // contained text to respect safe area insets.
                // Maybe the gradient should be in a ZStack?
                Spacer()
                    .frame(height: 22)
                HStack {
                    // TODO: Make a model for photos that includes date
                    // information that can be displayed here.
                    Text("\(Header.formatter.string(from: Date()))")
                        .font(Font.title.weight(.black))
                    Spacer()
                    HeaderActions()
                }
                HStack{
                    // TODO: Make a model for photos that includes location
                    // information that can be displayed here.
                    Text("Hong Kong")
                        .font(Font.caption.bold())
                    Spacer()
                }
            }
        .padding( EdgeInsets(top: 32, leading: 24, bottom: 0, trailing: 24) )
        .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.top)
    }

}

struct HeaderActions: View {

    private let buttonColor = Color("PillButton", bundle: Bundle.init(for: SharedLayout.self))

    @EnvironmentObject var layout: SharedLayout

    @State private var zooming: Bool = false
    @State private var selecting: Bool = false

    var body: some View {

        if self.zooming {
            return AnyView(zoomingLayout)
        }

        if self.selecting {
            return AnyView(selectingLayout)
        }

        return AnyView(rootLayout)
    }

    var zoomButton: some View {
        Button(action: {
            // TODO: Switch to add remove mode
            print("TODO: switch to add remove row mode")
            self.zooming = true
        }) {
            Capsule()
                .frame(width: 28, height: 28)
                .overlay(Image(systemName: "plus.slash.minus")
                    .font(Font.caption.bold())
                    .foregroundColor(.white)
                    .padding(0))
                .foregroundColor(self.buttonColor)
        }
    }

    var rootLayout: some View {
        HStack {
            Button(action: {
                // TODO: Switch to select mode
                self.selecting = true
            }) {
                Capsule()
                    .frame(width: 60, height: 28)
                    .overlay(Text("Select")
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                        .padding(0))
                    .foregroundColor(buttonColor)
            }
            zoomButton
        }
    }

    var selectingLayout: some View {
        HStack {
            Button(action: {
                // TODO: Switch to select mode
                self.selecting = false
            }) {
                Capsule()
                    .frame(width: 60, height: 28)
                    .overlay(Text("Cancel")
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                        .padding(0))
                    .foregroundColor(buttonColor)
            }
            zoomButton
        }
    }

    var zoomingLayout: some View {
        HStack {
            HStack(spacing: 2) {
                Button(action: {
                    // TODO: Our grid layout is really inefficient ane doesn't
                    // animate. Also, this maybe seems to get stuck transitioning
                    // from 1 to 3 per row.
                    self.layout.imagesPerRow += 2
                }) {
                    Image(systemName: "minus")
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(buttonColor)
                }
                .frame(height: 28)
                .cornerRadius(5)
                .disabled(self.layout.imagesPerRow >= 5)

                Button(action: {
                    self.layout.imagesPerRow -= 2
                }) {
                    Image(systemName: "plus")
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(buttonColor)
                }
                .frame(height: 28)
                .cornerRadius(5)
                .disabled(self.layout.imagesPerRow < 3)
            }
            .cornerRadius(14)

            Button(action: {
                self.zooming = false
            }) {
                Capsule()
                    .frame(width: 28, height: 28)
                    .overlay(Image(systemName: "xmark")
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                        .padding(0))
                    .foregroundColor(buttonColor)
            }
        }
    }
}
