//
//  DashboardMaster.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 20.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct DashboardMaster: View {

    var body: some View {
        ZStack {
            Color.light
                    .edgesIgnoringSafeArea(.all)
            VStack() {
                PerMilleScreen(alcoholObserver: AlcoholCalculator.instance)
                Spacer().frame(height: 30)
                VStack {
                    HStack {
                        NavigationLink(destination: DashboardSelection(type: .BEER)) {
                            DashboardDetail(type: .BEER)
                                    .padding(.all, 40)
                                    .frame(height: 250)
                                    .background(Color.white)
                                    .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())

                        Spacer().frame(width: 20.0)
                        NavigationLink(destination: DashboardSelection(type: .WINE)) {
                            DashboardDetail(type: .WINE)
                                    .padding(.all, 40)
                                    .frame(height: 250)
                                    .background(Color.white)
                                    .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer().frame(height: 20.0)
                    HStack {
                        NavigationLink(destination: DashboardSelection(type: .COCKTAIL)) {
                            DashboardDetail(type: .COCKTAIL)
                                    .padding(.all, 40)
                                    .frame(height: 250)
                                    .background(Color.white)
                                    .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())

                        Spacer().frame(width: 20.0)
                        NavigationLink(destination: DashboardSelection(type: .LIQUOR)) {
                            DashboardDetail(type: .LIQUOR)
                                    .padding(.all, 40)
                                    .frame(height: 250)
                                    .background(Color.white)
                                    .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }
        }
    }
}

struct DashboardMaster_Previews: PreviewProvider {
    static var previews: some View {
        DashboardMaster()
    }
}
