//
//  LocalStorage.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import RealmSwift
import Combine

class LocalStorage {
    static var shared = LocalStorage.init()
    let realm = try! Realm()
    
    func saveZipCodeData(zipcodeModel: ZipcodeModel) {
        try! realm.write {
            realm.add(zipcodeModel)
        }
    }
    
    func deleteData() {
        let data = realm.objects(ZipcodeModel.self)
        try! realm.write {
            realm.delete(data)
        }
    }
}
