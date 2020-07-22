//
//  PerMilleScreen.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 22.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct PerMilleScreen: View {
    let permille: Double
    let time: Double
    var body: some View {
        VStack {
            Text("Permille: \(permille)‰")
                .fontWeight(.bold)
            Spacer().frame(height: 20)
            Text("Sober in \(time)min").fontWeight(.light)
        }.foregroundColor(.white)
        .padding(.all, 20)
            .padding(.horizontal, 50.0)
        .background(Color.tertiary)
        .cornerRadius(20)
    }
}

struct PerMilleScreen_Previews: PreviewProvider {
    static var previews: some View {
        PerMilleScreen(permille: 3.5, time: 120)
    }
}
