//
//  ScopePicker.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/28/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

struct ScopePicker: View {

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
    @EnvironmentObject var layout: SharedLayout

    var body: some View {
        // I would like to use a geometry reader to get the height of the picker to inject into the shared layout
        // but I'm encountering two problems:
        // 1: wrapping the picker in a GeometryReader seems to expand the size the picker occupies:
        // 2: when the ScrollView in the photos scroller reads the value, it won't have been set by this or
        //    any descendent components. So it'll be 0. And the value won't be re-read when it updates.
        //        GeometryReader { geometry in
        //        Group {// geometry in
        Picker(selection: self.$scope, label: EmptyView()) {
            ForEach(Scope.allCases, id: \.self) { s in
                Text(s.name).tag(s)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .fixedSize()
//        .onAppear {
//            self.layout.pickerHeight = geometry.size.height
//        }
        //        }
        //        }
        //                .padding(0)
    }

}
