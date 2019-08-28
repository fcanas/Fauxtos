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
            }.padding()
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
                  "dawn-armfield-R9S19dOFlcs-unsplash"]]

struct PhotoList: View {
    var images: [[String]] = allImages
    var body: some View {
        List {
            ForEach(images, id: \.self) { i in
                PhotoRow(images: i)
            }.aspectRatio(3, contentMode: .fit)
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
