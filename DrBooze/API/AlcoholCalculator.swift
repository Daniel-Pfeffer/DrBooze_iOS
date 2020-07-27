//
// Created by Daniel Pfeffer on 22.07.20.
// Copyright (c) 2020 Daniel Pfeffer. All rights reserved.
//

import Foundation
import SwiftUI

class AlcoholCalculator: ObservableObject {

    var timer: Timer?
    static let instance = AlcoholCalculator()
    @Published var currentPermille: Double = 0.0
    private let reduction = 0.1 / 60

    private init() {
    }

    func startTimer() {
        self.timer = Timer(timeInterval: 1.0, target: self, selector: #selector(calculate), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }

    func stopTimer() {
        self.timer!.invalidate()
    }

    @objc private func calculate() {
        if self.currentPermille - reduction < 0 {
            self.currentPermille = 0
            self.stopTimer()
        } else {
            self.currentPermille -= reduction
        }
    }

    func addAlcohol(_ alcohol: Alcohol) {
        if self.currentPermille == 0 {
            self.startTimer()
        }
        self.currentPermille += self.calculateBac(alcohol)
    }

    func removeAlcohol(_ alcohol: Alcohol) {
        let a = self.calculateBac(alcohol)
        if self.currentPermille - a < 0 {
            self.currentPermille = 0
            self.stopTimer()
        } else {
            self.currentPermille -= a
        }
    }

    private func calculateBac(_ alcohol: Alcohol) -> Double {
        // calculate the mass of alcohol in a drink (0.8 = density of alcohol)
        let a = alcohol.amount * (alcohol.percentage / 100) * 0.8
        // calculate the permille change for a specific user (0.8 = amount of water in blood, 1.055 = density of blood)
        return (0.8 * a) / (1.055 * Shared.instance.user!.gkw!)
    }

    func savePermille() -> Double {
        guard self.currentPermille > 0 else {
            return 0.0
        }
        return self.currentPermille
    }

    func loadPermille(_ saved: Double, of time: Double) {
        if (saved != 0) {
            let minPassed = (Date().timeIntervalSince1970 - TimeInterval(exactly: time)!) / 60
            self.currentPermille = saved - minPassed * (reduction * 60)
            self.startTimer()
        }
    }
}
