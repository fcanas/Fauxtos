//
//  AllPhotos.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/27/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

struct AllPhotos: View {

    enum Scope: CaseIterable, Hashable, Identifiable {

        var id: Scope { self }

        case years
        case months
        case days
        case all

        var name: String {
            switch self {

            case .years:
                return "Years"
            case .months:
                return "Months"
            case .days:
                return "Days"
            case .all:
                return "All Photos"
            }
        }

    }

    @State var scope: Scope = .all

    var body: some View {
        ZStack{
            PhotoList()
            VStack {
                Spacer()
                Picker(selection: $scope, label: EmptyView()) {
                    ForEach(Scope.allCases, id: \.self) { s in
                        Text(s.name).tag(s)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                            .padding()
            }
        }
    }
}

let allImages = [["rikki-chan-B8ZFV4E0YOw-unsplash",
                  "casey-horner-T2l1NxKOsjY-unsplash",
                  "hugues-de-buyer-mimeure-lQPEChtLjUo-unsplash",],
                 ["will-turner-lqxMW8r-qJY-unsplash",
                  "johan-mouchet-Z95viY3WaZs-unsplash",
                  "matthew-henry-Ix1TiS-E17E-unsplash",],
                 ["joel-fulgencio-VSrHD079L78-unsplash",
                  "jasper-van-der-meij-eKpO8DlBvo0-unsplash",
                  "ethan-dow-6EljUULo4FQ-unsplash",],
                 ["daniel-norris-m_B6Rq976_E-unsplash",
                  "sead-dedic-thD4QhhV1J8-unsplash",
                  "kevin-crosby-pqV9L0IThCI-unsplash",],
                 ["gerson-repreza-hniuowbXbBY-unsplash",
                  "benjamin-voros-jv15x2Gs5F8-unsplash",
                  "dawn-armfield-R9S19dOFlcs-unsplash"],
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
    var images: [[String]] = allImages
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(self.images, id: \.self) { i in
                        PhotoRow(images: i)
                    }.aspectRatio(3, contentMode: .fit)
                    //                        .frame(width: geometry.size.width, alignment: .top)
                    // Acts as a content inset.
                    // I think we want to inject this from the environment
                    // The environment (zstack) would have it propagated from within, as the height
                    // of 
                    Spacer().frame(height: 60, alignment: .center)
                }
                    //                .frame(width: geometry.size.width, alignment: .top)
                    // I don't like this.
                    .frame(width: geometry.size.width, height: (geometry.size.width / 3) * CGFloat(self.images.count) , alignment: .top)
            }
            //            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)

        }
    }
}

struct PhotoRow: View {
    var images: [String]
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(self.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width / 3, height: geometry.size.width / 3, alignment: .center)
                        .clipped()
                }
            }
        }

    }
}
