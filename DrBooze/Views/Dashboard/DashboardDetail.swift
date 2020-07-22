//
//  DashboardDetail.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 20.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct DashboardDetail: View {
    let type: AlcoholType
    var body: some View {
        VStack{
            Spacer()
            Image(type.rawValue.lowercased()).resizable().frame(width: 52.0, height: 52.0)
            Spacer()
            Text(type.rawValue.lowercased().capitalized)
                .multilineTextAlignment(.center).frame(width: 75)
        }
    }
}

struct DashboardDetail_Previews: PreviewProvider {
    static var previews: some View {
        DashboardDetail(type: .COCKTAIL)
    }
}
