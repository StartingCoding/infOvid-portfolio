//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import SwiftUI
import Combine

final class DataDownloaded: ObservableObject {
    
    private var requests = Set<AnyCancellable>()
    
    // MARK: - Model
    
    private var countryData = Country()
    
    // MARK: - Access to the data in the model
    
    @Published var country: CountryDecodable
    @Published var regions: [CountryDecodable.RegionDecodable]
    
    init() {
        self.country = countryData.countryData.first ?? CountryDecodable.default
        self.regions = countryData.regionsData
        
        fetchData()
    }
    
    // MARK: - Intents
    
    /// It downloads the most recent JSON data available if there is the need to
    func fetchData() {
        let nowDate = Date()
        let downloadDateForCountryString = country.date
        let downloadDateForRegionsString = regions.first!.date
        
        guard isDownloadDateEmptyFor(downloadDateForCountryString, downloadDateForRegionsString) == false else { return }
        
        let formatter = ISO8601DateFormatter()
        let downloadDateForCountry = formatter.date(from: downloadDateForCountryString + "Z")
        let downloadDateForRegions = formatter.date(from: downloadDateForRegionsString + "Z")
        
        compareDates(of: nowDate, downloadDateForCountry!, downloadDateForRegions!)
    }
    
    /// // It checks if the download date is empty and then make the first download
    /// - Parameters:
    ///   - downloadDateForCountryString: the date to check for the country
    ///   - downloadDateForRegionsString: the date to check for the first region
    /// - Returns:It returns true if empty or false
    func isDownloadDateEmptyFor(_ downloadDateForCountryString: String, _ downloadDateForRegionsString: String) -> Bool {
        if downloadDateForCountryString.isEmpty || downloadDateForRegionsString.isEmpty {
            let urlCountry = URL(string: "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale-latest.json")!
            
            downloadingFrom(urlCountry, defaultValue: CountryDecodable.default) { data in
                self.country = data.first ?? CountryDecodable.default
            }
            
            let urlRegions = URL(string: "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni-latest.json")!
            
            downloadingFrom(urlRegions, defaultValue: CountryDecodable.RegionDecodable.default) { data in
                self.regions = data
            }
            return true
        } else {
            return false
        }
    }
    
    /// Update files if the various dates are older than the most recent date possible
    /// - Parameters:
    ///   - nowDate: The most recent date possible
    ///   - downloadDateForCountry: the date of download of the country
    ///   - downloadDateForRegions: the date of download of regions
    func compareDates(of nowDate: Date, _ downloadDateForCountry: Date, _ downloadDateForRegions: Date) {
        // DateComponenet for the date of right now
        let componentsOfNowDate = Calendar.current.dateComponents([.day, .hour], from: nowDate)
        let hourOfNowDate = componentsOfNowDate.hour ?? 0
        let dayOfNowDate = componentsOfNowDate.day ?? 0
        
        // DateComponenet for country
        let componentsOfDownloadDateForCountry = Calendar.current.dateComponents([.day, .hour], from: downloadDateForCountry)
        let hourOfDownloadDateForCountry = componentsOfDownloadDateForCountry.hour ?? 0
        let dayOfDownloadDateForCountry = componentsOfDownloadDateForCountry.day ?? 0
        
        // DateComponenet for regions
        let componentsOfDownloadDateForRegions = Calendar.current.dateComponents([.day, .hour], from: downloadDateForRegions)
        let hourOfDownloadDateForRegions = componentsOfDownloadDateForRegions.hour ?? 0
        let dayOfDownloadDateForRegions = componentsOfDownloadDateForRegions.day ?? 0
        
        // If download is old (generic)
        if nowDate > downloadDateForCountry || nowDate > downloadDateForRegions {
            // If download is old (day && hour - specific) for country
            if (dayOfNowDate > dayOfDownloadDateForCountry) && (hourOfNowDate >= hourOfDownloadDateForCountry) {
                
                let urlCountry = URL(string: "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale-latest.json")!
                
                downloadingFrom(urlCountry, defaultValue: CountryDecodable.default) { data in
                    self.country = data.first ?? CountryDecodable.default
                }
            }
            // If download is old (day && hour - specific) for regions
            if (dayOfNowDate > dayOfDownloadDateForRegions) && (hourOfNowDate >= hourOfDownloadDateForRegions) {
                let urlRegions = URL(string: "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni-latest.json")!
                
                downloadingFrom(urlRegions, defaultValue: CountryDecodable.RegionDecodable.default) { data in
                    self.regions = data
                }
            }
        }
    }
    
    /// Downloading from url using publishers from Combine
    /// - Parameters:
    ///   - url: The URL of the JSON file to be decoded
    ///   - defaultValue: The default value of the Decodable JSON (the property initialized with empty values like empty Strings and 0)
    ///   - completion: After the data is being successfully downloaded and successfully decoded from JSON, is being stored in some @Published properties
    func downloadingFrom<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping ([T]) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: [T].self, decoder: decoder)
            .replaceError(with: [defaultValue])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }
}
