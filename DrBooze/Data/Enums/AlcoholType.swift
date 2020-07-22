//
//  AlcoholType.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

enum AlcoholType: String, Codable, CaseIterable {
    case BEER = "BEER"
    case WINE = "WINE"
    case COCKTAIL = "COCKTAIL"
    case LIQUOR = "LIQUOR"
}
