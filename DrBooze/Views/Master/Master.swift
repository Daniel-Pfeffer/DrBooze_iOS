//
//  Master.swift
//  DrBooze
//
//  Created by Daniel Pfeffer on 22.06.20.
//  Copyright © 2020 Daniel Pfeffer. All rights reserved.
//

import SwiftUI

struct Master: View {
    var body: some View {
        TabView{
            DashboardMaster()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
            }
            HistoryMaster()
                .tabItem{
                    Image(systemName: "clock.fill")
                    Text("History")
            }
            ProfileMaster()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
            }
        }
    .navigationBarHidden(false)
    .navigationBarTitle("Dr. Booze")
    .navigationBarBackButtonHidden(true)
    }
}

struct Master_Previews: PreviewProvider {
    static var previews: some View {
        Master()
    }
}
