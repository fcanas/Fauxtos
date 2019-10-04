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
                VStack(spacing: self.layout.imageGridSpacing) {
                    ForEach(self.images, id: \.self) { i in
                        PhotoRow(images: i)
                    }

                    // ---!!!HACK!!!---
                    // Acts as a content inset for the containing scroll view.
                    // I think we want to inject this from the environment.
                    // The environment (zstack) would have it propagated from within, as the height
                    // of the scope picker. -- It looks kiind of right, but if we do actually write
                    // to the environment from the picker (which we're currently not), the Spacer
                    // is initialized with the initial value of the height, and is not updated
                    // until the tab is reloaded.
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
                    PhotoCell(imageName: imageName)
                        .frame(width: geometry.size.width / CGFloat(self.layout.imagesPerRow), height: (geometry.size.width / CGFloat(self.layout.imagesPerRow)), alignment: .center)
                        .clipped()
                }
            }
        }
        .aspectRatio(CGFloat(self.layout.imagesPerRow), contentMode: .fill)
    }
}

struct PhotoCell: View {
    @EnvironmentObject var layout: SharedLayout

    @State var selected: Bool = false

    var imageName: String
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            if self.layout.selecting {
                Button (action: { self.selected = !self.selected }) {
                    ZStack {
                        Rectangle()
                            .fill(Color
                                .white
                                .opacity(self.selected ? 0.25 : 0.0))
                        if self.selected {
                            ZStack {
                                Circle()
                                    .fill(Color.blue)
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 25, height: 25, alignment: Alignment(horizontal: .trailing, vertical: .bottom))
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
