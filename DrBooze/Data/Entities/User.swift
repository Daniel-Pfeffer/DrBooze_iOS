//
//  User.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation

class User: Codable, CustomStringConvertible {
    let username: String
    let email: String
    var firstName: String?
    var lastName: String?
    var gender: String
    var birthday: Int
    var height: Double
    var weight: Double
    var points: Int
    var gkw: Double?

    init(username: String, email: String, firstName: String?, lastName: String?, gender: String, birthday: Int, height: Double, weight: Double) {
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.gkw = 0.0
        self.points = 0
    }

    func calculateGKW() {
        self.birthday = self.birthday / 1000
        var age = (Date().timeIntervalSince1970 - TimeInterval(exactly: self.birthday)!) / 31536000
        age.round(.down)

        switch self.gender.uppercased() {
        case "M":
            self.gkw = 2.447 - (0.09516 * age) + (0.1074 * self.height) + (0.3362 * self.weight)
        case "W":
            self.gkw = -2.097 + (0.1069 * self.height) + (0.2466 * self.weight)
        default:
            self.gkw = 0.0
        }
    }

    var description: String {
        "User(username: \(username), email: \(email), firstName: \(firstName), lastName: \(lastName), gender: \(gender), birthday: \(birthday), height: \(height), weight: \(weight), points: \(points), gkw: \(gkw))"
    }
}
