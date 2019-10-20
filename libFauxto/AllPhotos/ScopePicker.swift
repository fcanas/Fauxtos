//
//  ScopePicker.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/28/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import SwiftUI

/// Defines a Picker that selects one of a union of "scopes" for changing how photos are displayed.
struct ScopePicker: View {

    enum Scope: CaseIterable, Hashable {

        case years
        case months
        case days
        case all

        // TODO: is this remotely correct, or are there better, more accessible ways?
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

    // TODO: How do I propagate the state up to the "Collection View" of
    // photos? Does that need to go in the @EnvironmentObject, or can
    // @State properties be propagated up further?
    @State var scope: Scope = .all
    @EnvironmentObject var layout: SharedLayout

    var body: some View {
        // TODO:
        // I would like to use a geometry reader to get the height of the
        // picker to inject into the shared layout but I'm encountering
        // two problems:
        // 1: wrapping the picker in a GeometryReader seems to expand the
        //    size the picker occupies.
        // 2: when the ScrollView in the photos scroller reads the value,
        //    it won't have been set by this or any descendent components.
        //    So it'll be 0. And the value won't be re-read when it updates.

        Picker(selection: self.$scope, label: EmptyView()) {
            ForEach(Scope.allCases, id: \.self) { s in
                Text(s.name)
                    .tag(s)
            }
        }
            // TODO: Make the style _more_ like in Photos. BlurView below is one step.
            .pickerStyle(SegmentedPickerStyle())
            .background(BlurView()
                .cornerRadius(15))
            .padding()
            .fixedSize()
    }

}

extension ScopePicker.Scope : Identifiable {
    var id: ScopePicker.Scope { self }
}


// Blur View by Matteo Pacini
// https://github.com/Zi0P4tch0
// https://stackoverflow.com/questions/56610957/is-there-a-method-to-blur-a-background-in-swiftui
// With modifications for responding to environment color changes
struct BlurView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    let style: UIBlurEffect.Style? = nil

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style ?? .systemMaterial)
        install(effect: blurEffect, inView: view)
        return view
    }

    func install(effect: UIBlurEffect, inView view: UIView) {
        let blurView = UIVisualEffectView(effect: effect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}
