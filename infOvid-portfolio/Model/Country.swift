//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import Foundation

struct Country {
    var countryData: [CountryDecodable]
    var regionsData: [CountryDecodable.RegionDecodable]
    
    init() {
        countryData = [CountryDecodable.default]
        regionsData = [CountryDecodable.RegionDecodable.default]
    }
}
