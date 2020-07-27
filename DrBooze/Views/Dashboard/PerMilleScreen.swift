//
//  PerMilleScreen.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 22.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct PerMilleScreen: View {
    @ObservedObject var alcoholObserver: AlcoholCalculator
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Permille: \(alcoholObserver.currentPermille, specifier: "%.2f")‰")
                        .fontWeight(.bold)
                        .fixedSize(horizontal: true, vertical: false)
                Spacer().frame(height: 20)

                Text("Sober in \((alcoholObserver.currentPermille / 0.1).rounded(.down), specifier: "%.0f")h \((alcoholObserver.currentPermille / 0.1 * 60).truncatingRemainder(dividingBy: 60), specifier: "%.0f")min")
                        .fontWeight(.light)
                        .fixedSize(horizontal: true, vertical: false)
            }
                    .foregroundColor(.white)
                    .padding(.all, 20)
                    .padding(.horizontal, 50.0)
                    .background(Color.tertiary)
                    .cornerRadius(20)
            Spacer()
        }
    }
}

struct PerMilleScreen_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            VStack {
                Text("Permille: \(0.4, specifier: "%.2f")‰")
                        .fontWeight(.bold)
                Spacer().frame(height: 20)

                Text("Sober in \((0.4 / 0.1).rounded(.down), specifier: "%.0f")h \((0.4 / 0.1 * 60).truncatingRemainder(dividingBy: 60), specifier: "%.0f")min").fontWeight(.light)
            }.foregroundColor(.white)
                    .padding(.all, 20)
                    .padding(.horizontal, 50.0)
                    .background(Color.tertiary)
                    .cornerRadius(20)
            Spacer()
        }
    }
}
