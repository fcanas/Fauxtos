//
//  Media.swift
//  libFauxto
//
//  Created by Fabián Cañas on 8/29/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import Foundation

public class MediaLibrary: ObservableObject {

    public init(photos: [Photo]) {
        self.photos = photos
    }

    let photos: [Photo]
}

public struct Photo: Codable {
    let identifier: String
    let photographer: String
    let url: String

    var assetName: String {
        "\(photographer.lowercased().split(separator: " ").joined(separator: "-"))-\(identifier)-unsplash"
    }
}

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
