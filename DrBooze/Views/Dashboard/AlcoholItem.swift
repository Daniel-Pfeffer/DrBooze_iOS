//
//  AlcoholItem.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 19.07.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct AlcoholItem: View {
    let alcohol: Alcohol
    var body: some View {
        HStack {
            Image(alcohol.type.rawValue.lowercased()).resizable().frame(width: 35.0, height: 35.0)
            VStack(alignment: .leading, spacing: 1.0) {
                Text(alcohol.name).lineLimit(1)

                Text("\(alcohol.percentage, specifier: "%.1f")%")
                        .foregroundColor(.gray)

            }.multilineTextAlignment(.leading)
            Spacer()
            Text("\(alcohol.amount, specifier: "%.0f")ml")
                    .multilineTextAlignment(.trailing)
            Spacer()
                    .frame(width: 10.0)
        }
    }
}

struct AlcoholItem_Previews: PreviewProvider {
    static var previews: some View {
        AlcoholItem(alcohol: Alcohol(id: 7, type: .BEER, name: "Rieder Märzen", percentage: 4.9, amount: 330, category: nil, isPersonal: false))
    }
}
