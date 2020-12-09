//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import Combine
import SwiftUI

struct ItalyView: View {
    @EnvironmentObject var data: DataDownloaded
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(data.country.displayDateForState)) {
                    HStack {
                        Text("newPositive")
                        Spacer()
                        Text("\(data.country.newPositive)")
                    }
                    .padding()
                    
                    HStack {
                        Text("changeTotalPositive")
                        Spacer()
                        Text("\(data.country.changeTotalPositive)")
                    }
                    .padding()
                    
                    HStack {
                        Text("intensiveCare")
                        Spacer()
                        Text("\(data.country.intensiveCare)")
                    }
                    .padding()
                    
                    HStack {
                        Text("homeIsolation")
                        Spacer()
                        Text("\(data.country.homeIsolation)")
                    }
                    .padding()
                }
                
                Section {
                    HStack {
                        Text("totalPositive")
                        Spacer()
                        Text("\(data.country.totalPositive)")
                    }
                    
                    HStack {
                        Text("totalHospitalized")
                        Spacer()
                        Text("\(data.country.totalHospitalized)")
                    }
                    
                    HStack {
                        Text("hospitalizedWithSymptoms")
                        Spacer()
                        Text("\(data.country.hospitalizedWithSymptoms)")
                    }
                    
                    HStack {
                        Text("dischargedHealed")
                        Spacer()
                        Text("\(data.country.dischargedHealed)")
                    }
                    
                    HStack {
                        Text("deads")
                        Spacer()
                        Text("\(data.country.deads)")
                    }
                    
                    HStack {
                        Text("totalCases")
                        Spacer()
                        Text("\(data.country.totalCases)")
                    }
                    
                    HStack {
                        Text("swabs")
                        Spacer()
                        Text("\(data.country.swabs)")
                    }
                }
                
                if data.country.note.isEmpty == false {
                    Section {
                        Text("Note it: \(data.country.note)")
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
            .navigationBarTitle(Text("italyTitle"))
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        ItalyView()
    }
}
