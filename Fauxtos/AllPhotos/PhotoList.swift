//
//  PhotoList.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/28/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

let allImages = [["rikki-chan-B8ZFV4E0YOw-unsplash",
                  "casey-horner-T2l1NxKOsjY-unsplash",
                  "hugues-de-buyer-mimeure-lQPEChtLjUo-unsplash",],
                 ["will-turner-lqxMW8r-qJY-unsplash",
                  "johan-mouchet-Z95viY3WaZs-unsplash",
                  "matthew-henry-Ix1TiS-E17E-unsplash",],
                 ["dawn-armfield-R9S19dOFlcs-unsplash",
                  "jasper-van-der-meij-eKpO8DlBvo0-unsplash",
                  "ethan-dow-6EljUULo4FQ-unsplash",],
                 ["gerson-repreza-hniuowbXbBY-unsplash",
                  "kevin-crosby-pqV9L0IThCI-unsplash",
                  "benjamin-voros-jv15x2Gs5F8-unsplash",],
                 ["daniel-norris-m_B6Rq976_E-unsplash",
                  "sead-dedic-thD4QhhV1J8-unsplash",
                  "joel-fulgencio-VSrHD079L78-unsplash"],
                 ["sankalp-sharma-S2AIYYVyBLc-unsplash",
                  "nicolas-hoizey-hfIMkIcIq_k-unsplash",
                  "mark-hang-fung-so--qDAqOS_Chk-unsplash",],
                 ["senor-sosa-9Kh9K2Cc5y0-unsplash",
                  "brayden-law-F6YJRn46SMM-unsplash",
                  "joel-fulgencio-pXKW6bBwsnA-unsplash",],
                 //                 ["airam-dato-on-5AgkxBHhXg8-unsplash",
    //                  "jamie-street-8_xzhWgK9wo-unsplash",
    //                  "ethan-lee-RxpOfYtpoa0-unsplash",]
]

struct PhotoList: View {
    @EnvironmentObject var layout: SharedLayout
    var images: [[String]] = allImages
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 4) {
                    ForEach(self.images, id: \.self) { i in
                            PhotoRow(images: i)
                    }

                    // Acts as a content inset for the containing scroll view.
                    // I think we want to inject this from the environment
                    // The environment (zstack) would have it propagated from within, as the height
                    // of
                    Spacer(minLength: self.layout.pickerHeight)//.frame(height: self.layout.pickerHeight + 400, alignment: .center)
                }
            }
        }
    }
}

struct PhotoRow: View {
    var images: [String]
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 4.0) {
                ForEach(self.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width / 3, height: (geometry.size.width / 3), alignment: .center)
                        .clipped()
                }
            }
        }
        .aspectRatio(3, contentMode: .fill)
    }
}
