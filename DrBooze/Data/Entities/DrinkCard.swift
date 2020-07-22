//
//  DrinkCard.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

struct DrinkCard {
    let type: AlcoholType
    let title: String
    let iconName: String
    let iconMode: String

    init(type: AlcoholType, title: String, iconName: String, iconMode: String) {
        self.type = type
        self.title = title
        self.iconName = iconName
        self.iconMode = iconMode
    }
}
