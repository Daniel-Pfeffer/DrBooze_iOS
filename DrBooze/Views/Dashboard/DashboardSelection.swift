//
//  DashboardSelection.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 16.07.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct DashboardSelection: View {
    let type: AlcoholType
    let dashboard = DashboardController.instance
    @State var alcohol: Array<AlcoholListStruct> = []
    var body: some View {
        VStack {
            if self.alcohol.count > 0 {
               List {
                    ForEach(self.alcohol, id: \.self) { (menu: AlcoholListStruct) in
                        Section(header: Text(menu.category.capitalized)) {
                            ForEach(menu.alcohol) { alc in
                                AlcoholItem(alcohol: alc)
                            }
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }.onAppear() {
            self.dashboard.loadAlcohol(type: self.type, binding: self.$alcohol)
        }
        .navigationBarTitle(type.rawValue.lowercased().capitalized)
        .listStyle(GroupedListStyle())
    }
}

struct DashboardSelection_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSelection(type: .BEER)
    }
}
