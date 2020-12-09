//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import SwiftUI

struct RegionRow: View {
    var region: CountryDecodable.RegionDecodable
    
    var body: some View {
        Text(region.regionName)
    }
}

struct RegionRow_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            RegionRow(region: regionData[0])
//            RegionRow(region: regionData[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
        Text("Hello World!")
    }
}
