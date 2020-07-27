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
    @State var selectedAlcohol: Alcohol?

    var body: some View {
        VStack {
            if self.alcohol.count > 0 {
                List {
                    ForEach(self.alcohol, id: \.self) { (menu: AlcoholListStruct) in
                        Section(header: HStack {
                            Text(menu.category.capitalized)
                            if menu.category == "Favourite" {
                                Image(systemName: "heart.fill")
                            } else {
                                EmptyView()
                            }
                        }) {
                            ForEach(menu.alcohol) { (alc: Alcohol) in
                                NavigationLink(destination: Master(), tag: alc, selection: self.customBinding()) {
                                    AlcoholItem(alcohol: alc)
                                }.contextMenu {
                                    if alc.category == "Favourite" {
                                        Button(action: {
                                            self.alcohol[0].alcohol.removeAll(where: { $0.id == alc.id })
                                            self.dashboard.removeFromFavourites(alc.id)
                                        }) {
                                            Text("Remove Favourite")
                                            Image(systemName: "heart.slash.fill")
                                        }
                                    } else {
                                        Button(action: {
                                            // add to favourite
                                            var newAlc = alc
                                            newAlc.isFavourite()
                                            if !(self.alcohol[0].alcohol.contains(where: { $0.id == alc.id })) {
                                                self.alcohol[0].alcohol.append(newAlc)
                                                self.dashboard.addToFavourites(newAlc.id)
                                            }
                                        }) {
                                            Text("Add Favourite")
                                            Image(systemName: "heart.fill")
                                        }
                                    }

                                    if alc.validatePersonal() {
                                        Button(action: {
                                            var counter = 0

                                            self.alcohol.forEach { listStruct in
                                                self.alcohol[counter].alcohol.removeAll(where: { $0.id == alc.id })
                                                counter += 1
                                            }

                                            self.dashboard.deleteAlcohol(alc.id)
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash.fill")
                                        }
                                    } else {
                                        EmptyView()
                                    }
                                }
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

    func customBinding() -> Binding<Alcohol?> {
        let binding = Binding<Alcohol?>(get: {
            self.selectedAlcohol
        }, set: {
            if ($0 != nil) {
                AlcoholCalculator.instance.addAlcohol($0!)
            }
            self.selectedAlcohol = $0
        })
        return binding
    }
}

struct DashboardSelection_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSelection(type: .BEER)
    }
}
