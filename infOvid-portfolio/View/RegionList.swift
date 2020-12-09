//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import SwiftUI
import Combine

struct RegionList: View {
    @EnvironmentObject var data: DataDownloaded
    @EnvironmentObject var dataSettings: UserSettings
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if dataSettings.showPersonalToggle {
                        Toggle(isOn: $dataSettings.showPersonalListToggle) {
                            Text("personalPreference")
                        }
                    }
                
                    if dataSettings.showPersonalListToggle {
                        ForEach(data.regions, id: \.regionNumber) { region in
                            if dataSettings.isRegionIsFavourite(region.regionNumber) {
                                NavigationLink(destination: RegionDetail(region: region)) {
                                    RegionRow(region: region)
                                }
                            }
                        }
                    }
                }
                
                Section {
                    ForEach(data.regions, id: \.regionNumber) { region in
                        NavigationLink(destination: RegionDetail(region: region)) {
                            RegionRow(region: region)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button {
                            data.fetchData()
                            
                            showingAlert = true
                        } label: {
                            Label("downloadRecentData", systemImage: "square.and.arrow.down")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .clipShape(Capsule())
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Dati Aggiornati"), dismissButton: .default(Text("Ok")))
                        }
                        
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .padding()
            }
            .navigationBarTitle(Text("regionsTitle"))
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct RegionList_Previews: PreviewProvider {
    static var previews: some View {
        RegionList()
            .environmentObject(DataDownloaded())
    }
}
