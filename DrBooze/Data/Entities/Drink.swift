//
//  Drink.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

struct Drink: Codable {
    let id: Int
    let alcohol: Alcohol
    let drankDate: Double
    let longitude: Double
    let latitude: Double

    init(id: Int, alcohol: Alcohol, drankDate: Double, longitude: Double, latitude: Double) {
        self.id = id
        self.alcohol = alcohol
        self.drankDate = drankDate
        self.longitude = longitude
        self.latitude = latitude
    }
}
