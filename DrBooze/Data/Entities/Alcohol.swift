//
//  Alcohol.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

struct Alcohol: Codable, Identifiable, Hashable {
    let id: Int
    let type: AlcoholType
    let name: String
    let percentage: Double
    let amount: Double
    var category: String?
    var isPersonal: Bool?

    mutating func checkCategory() {
        if (self.category == nil) {
            self.category = "Regular"
        }
    }

    mutating func isFavourite() {
        self.category = "Favourite"
    }

    func validatePersonal() -> Bool {
        guard let isPersonal = self.isPersonal, isPersonal else {
            return false
        }
        return true
    }
}
