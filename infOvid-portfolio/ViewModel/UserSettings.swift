//
//  infOvid_portfolioApp.swift
//  infOvid-portfolio
//
//  Created by Loris on 12/9/20.
//

import Foundation

final class UserSettings: ObservableObject {
    
    // MARK: - Access to user settings
    
    @Published var showPersonalToggle: Bool {
        didSet {
            UserDefaults.standard.set(showPersonalToggle, forKey: "showPersonalToggle")
        }
    }

    @Published var showPersonalListToggle: Bool {
        didSet {
            UserDefaults.standard.set(showPersonalListToggle, forKey: "showPersonalListToggle")
        }
    }

    @Published var favouriteRegions: [Int] {
        didSet {
            UserDefaults.standard.set(favouriteRegions, forKey: "favouriteRegions")
        }
    }

    init() {
        self.showPersonalToggle = UserDefaults.standard.object(forKey: "showPersonalToggle") as? Bool ?? false
        self.showPersonalListToggle = UserDefaults.standard.object(forKey: "showPersonalListToggle") as? Bool ?? false

        self.favouriteRegions = UserDefaults.standard.object(forKey: "favouriteRegions") as? [Int] ?? []
    }
    
    // MARK: - Intents
    
    /// This update the array that holds all the favourite regions
    /// - Parameter regionNumber: is the code of the region that is unique per region
    func upadateUserSettings(with regionNumber: Int) {
        if isRegionIsFavourite(regionNumber) {
            let index = favouriteRegions.firstIndex(of: regionNumber)!
            favouriteRegions.remove(at: index)
        } else {
            favouriteRegions.append(regionNumber)
        }
        
        if favouriteRegions.isEmpty {
            showPersonalToggle = false
            showPersonalListToggle = false
        } else {
            showPersonalToggle = true
            showPersonalListToggle = true
        }
    }
    
    func isRegionIsFavourite(_ regionNumber: Int) -> Bool {
        return favouriteRegions.contains(regionNumber) ? true : false
    }
}
