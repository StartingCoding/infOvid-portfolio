//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import Foundation

struct CountryDecodable: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case date = "data"
        case state = "stato"
        case hospitalizedWithSymptoms = "ricoveratiConSintomi"
        case intensiveCare = "terapiaIntensiva"
        case totalHospitalized = "totaleOspedalizzati"
        case homeIsolation = "isolamentoDomiciliare"
        case totalPositive = "totalePositivi"
        case changeTotalPositive = "variazioneTotalePositivi"
        case newPositive = "nuoviPositivi"
        case dischargedHealed = "dimessiGuariti"
        case deads = "deceduti"
        case positiveFromClinicalActivity = "casiDaSospettoDiagnostico"
        case positiveFromScreening = "casiDaScreening"
        case totalCases = "totaleCasi"
        case swabs = "tamponi"
        case note = "note"
    }
    
    var date: String
    var state: String
    var hospitalizedWithSymptoms: Int
    var intensiveCare: Int
    var totalHospitalized: Int
    var homeIsolation: Int
    var totalPositive: Int
    var changeTotalPositive: Int
    var newPositive: Int
    var dischargedHealed: Int
    var deads: Int
    var positiveFromClinicalActivity: Int
    var positiveFromScreening: Int
    var totalCases: Int
    var swabs: Int
    var note: String
    
    static let `default` = CountryDecodable(date: "", state: "", hospitalizedWithSymptoms: 0, intensiveCare: 0, totalHospitalized: 0, homeIsolation: 0, totalPositive: 0, changeTotalPositive: 0, newPositive: 0, dischargedHealed: 0, deads: 0, positiveFromClinicalActivity: 0, positiveFromScreening: 0, totalCases: 0, swabs: 0, note: "")
    
    
    struct RegionDecodable: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case lat, long
            
            case regionNumber = "codiceRegione"
            case regionName = "denominazioneRegione"
            case tested = "casiTestati"
            case date = "data"
            case state = "stato"
            case hospitalizedWithSymptoms = "ricoveratiConSintomi"
            case intensiveCare = "terapiaIntensiva"
            case totalHospitalized = "totaleOspedalizzati"
            case homeIsolation = "isolamentoDomiciliare"
            case totalPositive = "totalePositivi"
            case changeTotalPositive = "variazioneTotalePositivi"
            case newPositive = "nuoviPositivi"
            case dischargedHealed = "dimessiGuariti"
            case deads = "deceduti"
            case positiveFromClinicalActivity = "casiDaSospettoDiagnostico"
            case positiveFromScreening = "casiDaScreening"
            case totalCases = "totaleCasi"
            case swabs = "tamponi"
            case note = "note"
        }
        
        var regionNumber: Int
        var regionName: String
        var lat: Double
        var long: Double
        var tested: Int
        var date: String
        var state: String
        var hospitalizedWithSymptoms: Int
        var intensiveCare: Int
        var totalHospitalized: Int
        var homeIsolation: Int
        var totalPositive: Int
        var changeTotalPositive: Int
        var newPositive: Int
        var dischargedHealed: Int
        var deads: Int
        var positiveFromClinicalActivity: Int
        var positiveFromScreening: Int
        var totalCases: Int
        var swabs: Int
        var note: String?
        
        static let `default` = RegionDecodable(regionNumber: 0, regionName: "", lat: 0.0, long: 0.0, tested: 0, date: "", state: "", hospitalizedWithSymptoms: 0, intensiveCare: 0, totalHospitalized: 0, homeIsolation: 0, totalPositive: 0, changeTotalPositive: 0, newPositive: 0, dischargedHealed: 0, deads: 0, positiveFromClinicalActivity: 0, positiveFromScreening: 0, totalCases: 0, swabs: 0, note: "")
    }
}

extension CountryDecodable {
    var displayDateForState: String {
        let formatter = ISO8601DateFormatter()
        let downloadDate = formatter.date(from: date + "Z")
        
        guard downloadDate != nil else { return "Ancora nessun download!" }
        
        let componentsOfDownloadDate = Calendar.current.dateComponents([.year, .month, .day, .hour], from: downloadDate!)
        let yearOfDownloadDate = componentsOfDownloadDate.year ?? 0
        let monthOfDownloadDate = componentsOfDownloadDate.month ?? 0
        let dayOfDownloadDate = componentsOfDownloadDate.day ?? 0
        let hourOfDownloadDate = componentsOfDownloadDate.hour ?? 0
        
        let dataUpdate = NSLocalizedString("dataUpdate", comment: "")
        let dataUpdateSecond = NSLocalizedString("dataUpdateSecond", comment: "")
        
        return "\(dataUpdate) \(dayOfDownloadDate)-\(monthOfDownloadDate)-\(yearOfDownloadDate) \(dataUpdateSecond) \(hourOfDownloadDate)"
    }
}

extension CountryDecodable.RegionDecodable {
    var displayDateForRegion: String {
        let formatter = ISO8601DateFormatter()
        let downloadDate = formatter.date(from: date + "Z")
        
        guard downloadDate != nil else { return "Ancora nessun download!" }
        
        let componentsOfDownloadDate = Calendar.current.dateComponents([.year, .month, .day, .hour], from: downloadDate!)
        let yearOfDownloadDate = componentsOfDownloadDate.year ?? 0
        let monthOfDownloadDate = componentsOfDownloadDate.month ?? 0
        let dayOfDownloadDate = componentsOfDownloadDate.day ?? 0
        let hourOfDownloadDate = componentsOfDownloadDate.hour ?? 0
        
        let dataUpdate = NSLocalizedString("dataUpdate", comment: "")
        let dataUpdateSecond = NSLocalizedString("dataUpdateSecond", comment: "")
        
        return "\(dataUpdate) \(dayOfDownloadDate)-\(monthOfDownloadDate)-\(yearOfDownloadDate) \(dataUpdateSecond) \(hourOfDownloadDate)"
    }
}
