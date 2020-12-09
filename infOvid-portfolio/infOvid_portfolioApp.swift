//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import SwiftUI

@main
struct infOvid_portfolioApp: App {
    @ObservedObject var data = DataDownloaded()
    @ObservedObject var dataSettings = UserSettings()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ItalyView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("italyTabBar")
                    }
                RegionList()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("regionsTabBar")
                    }
            }
            .environmentObject(data)
            .environmentObject(dataSettings)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                data.fetchData()
            case .inactive: break
                // Do nothing
            case .background: break
                // Do nothing
            @unknown default:
                print("Some new different state implemented by Apple")
            }
        }
    }
}
