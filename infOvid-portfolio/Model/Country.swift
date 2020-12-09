//
//  Country.swift
//  infOvid
//
//  Created by Loris on 4/13/20.
//  Copyright © 2020 Loris. All rights reserved.
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
