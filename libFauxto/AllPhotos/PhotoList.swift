//
//  PhotoList.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/28/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

struct PhotoList: View {
    @EnvironmentObject var layout: SharedLayout
    @EnvironmentObject var mediaLibrary: MediaLibrary

    var images: [[String]] {
        return self.mediaLibrary.photos.reduce([[]]) { (result, photo) -> [[String]] in
            var vResult = result

            if vResult.last!.count == layout.imagesPerRow {
                vResult.append([])
            }

            var vLast = vResult.last!
            vLast.append(photo.assetName)
            vResult[vResult.endIndex.advanced(by: -1)] = vLast

            return vResult
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: self.layout.imageGridSpacing / 2.0) {
                    ForEach(self.images, id: \.self) { i in
                        PhotoRow(images: i)
                    }

                    // ---!!!HACK!!!---
                    // Acts as a content inset for the containing scroll view.
                    // I think we want to inject this from the environment.
                    // The environment (zstack) would have it propagated from within, as
                    // the height of the scope picker. -- It looks kind of right, but if
                    // we write to the environment from the picker (which we're currently
                    // not), the Spacer is initialized with the initial value of the height,
                    // and is not updated until the tab is reloaded.
                    Spacer(minLength: self.layout.pickerHeight)
                }
            }
        }
    }
}

struct PhotoRow: View {
    @EnvironmentObject var layout: SharedLayout

    var images: [String]
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: self.layout.imageGridSpacing) {
                ForEach(self.images, id: \.self) { imageName in
                    PhotoCell(size: (geometry.size.width / CGFloat(self.layout.imagesPerRow)) - (CGFloat(self.layout.imagesPerRow - 1) * self.layout.imageGridSpacing) / CGFloat(self.layout.imagesPerRow),
                              imageName: imageName)
                }
            }
        }
        .aspectRatio(CGFloat(self.layout.imagesPerRow), contentMode: .fill)
    }
}

struct PhotoCell: View {
    @EnvironmentObject var layout: SharedLayout

    @State var selected: Bool = false

    var size: CGFloat
    var imageName: String
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipped()
            if self.layout.selecting {
                SelectionOverlay(selected: selected)
            }
        }
    }
}

struct SelectionOverlay: View {
    @State var selected: Bool
    var body: some View {
        Button (action: { self.selected = !self.selected }) {
            ZStack {
                Rectangle()
                    .fill(Color
                        .white
                        .opacity(self.selected ? 0.25 : 0.0))
                if self.selected {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            CheckMark()
                            .padding(3)
                        }
                    }
                }
            }
        }
    }
}

struct CheckMark: View {

    // TODO: How to make this view honor things like
    // foregroundColor and backgroundColor from modifiers, or... whetever
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var size: CGFloat = 25

    var body: some View {
        ZStack {
            // Dropshadow
            Circle()
                .fill(Color.black
                    .opacity(0.7))
                .blur(radius: 5)
            // Background
            Circle()
                .fill(backgroundColor)
            // Symbol
            Image(systemName: "checkmark.circle").font(Font.system(size: size, weight: .light))
                .foregroundColor(foregroundColor)
        }
        .frame(width: size, height: size)
    }
}

