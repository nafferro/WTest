//
//  LocalStorage.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import RealmSwift

class LocalStorage {
    static var shared = LocalStorage.init()
    let realm = try! Realm()
    
    // SETTINGS

    
    func saveSettings(settingsModel: SettingsModel) {
        let realmObj = realm.objects(SettingsModel.self)

        if realmObj.first != nil {
            self.updateSettings(fileLoaded: settingsModel.fileLoaded, databaseLoaded: settingsModel.databaseLoaded)
        }
        else {
            try! realm.write {
                realm.add(settingsModel)
            }
        }
    }
    
    func updateSettings(fileLoaded: Bool? = nil, databaseLoaded: Bool? = nil) {
        let settings = realm.objects(SettingsModel.self)
        if let tempSettings = settings.first {
            try! realm.write {
                if let fileLoaded = fileLoaded { tempSettings.fileLoaded = fileLoaded }
                if let databaseLoaded = databaseLoaded { tempSettings.databaseLoaded = databaseLoaded }
            }
        }
    }
    
    func loadSettings() -> SettingsModel {
        print("Realm is located at:", realm.configuration.fileURL!)
        let settings = realm.objects(SettingsModel.self)
        if let tempSettings = settings.first {
            return tempSettings
        }
        return SettingsModel()
    }
    
    
    // ZIP CODES
    
    func saveZipCodeData(zipcodeModel: ZipcodeModel) {
        try! realm.write {
            realm.add(zipcodeModel)
        }

    }
    
    func getZipCodesTotal() -> Int {
        let zipcodes = realm.objects(ZipcodeModel.self)
        return zipcodes.count
    }
    
    func deleteData() {
        let data = realm.objects(ZipcodeModel.self)
        try! realm.write {
            realm.delete(data)
        }
    }
}
