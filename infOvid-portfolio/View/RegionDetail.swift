//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import Combine
import SwiftUI

struct RegionDetail: View {
    @EnvironmentObject var data: DataDownloaded
    @EnvironmentObject var dataSettings: UserSettings
    
    var regionIndex: Int {
        data.regions.firstIndex(where: { $0.regionNumber == region.regionNumber })!
    }
    
    var region: CountryDecodable.RegionDecodable
    
    var body: some View {
        List {
            Section(header: Text(region.displayDateForRegion)) {
                HStack {
                    Text("newPositive")
                    Spacer()
                    Text("\(region.newPositive)")
                }
                .padding()
                
                HStack {
                    Text("changeTotalPositive")
                    Spacer()
                    Text("\(region.changeTotalPositive)")
                }
                .padding()

                HStack {
                    Text("intensiveCare")
                    Spacer()
                    Text("\(region.intensiveCare)")
                }
                .padding()
                
                HStack {
                    Text("homeIsolation")
                    Spacer()
                    Text("\(region.homeIsolation)")
                }
                .padding()
            }
            
            Section {
                HStack {
                    Text("totalPositive")
                    Spacer()
                    Text("\(region.totalPositive)")
                }
                
                HStack {
                    Text("totalHospitalized")
                    Spacer()
                    Text("\(region.totalHospitalized)")
                }
                
                HStack {
                    Text("hospitalizedWithSymptoms")
                    Spacer()
                    Text("\(region.hospitalizedWithSymptoms)")
                }
                
                HStack {
                    Text("dischargedHealed")
                    Spacer()
                    Text("\(region.dischargedHealed)")
                }
                
                HStack {
                    Text("deads")
                    Spacer()
                    Text("\(region.deads)")
                }
                
                HStack {
                    Text("totalCases")
                    Spacer()
                    Text("\(region.totalCases)")
                }

                HStack {
                    Text("swabs")
                    Spacer()
                    Text("\(region.swabs)")
                }
                
                HStack {
                    Text("tested")
                    Spacer()
                    Text("\(region.tested)")
                }
            }
            
            if region.note != nil {
                Section {
                    Text("Note it: \(region.note ?? "")")
                }
            }

            Section {
                HStack {
                    Text("regionNumber")
                    Spacer()
                    Text("\(region.regionNumber)")
                }
                
                HStack {
                    Text("lat")
                    Spacer()
                    Text("\(region.lat)")
                }
                
                HStack {
                    Text("long")
                    Spacer()
                    Text("\(region.long)")
                }
            }
        }
        .navigationBarTitle(Text(region.regionName))
        .navigationBarItems(trailing:
            Button(action: {
                dataSettings.upadateUserSettings(with: region.regionNumber)
            }, label: {
                if dataSettings.isRegionIsFavourite(region.regionNumber) {
                    Image(systemName: "star.fill")
                        .imageScale(.medium)
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
            })
        )
        .listStyle(InsetGroupedListStyle())
    }
}

//struct RegionDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RegionDetail(region: regionData[0])
//    }
//}
