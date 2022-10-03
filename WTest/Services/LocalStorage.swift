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
        print("Realm is located at:", realm.configuration.fileURL!)
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
    
    func changeFilter(_ word: String) -> Results<ZipcodeModel> {
        DispatchQueue.global(qos: .background).sync {
            var result: Results<ZipcodeModel>? = nil
            let realm = try! Realm()
            if word.count > 3 {
                 result = realm.objects(ZipcodeModel.self).filter(NSPredicate(format: "city CONTAINS[cd] %@ OR zipcode CONTAINS %@", word, word))
             }
            return result ?? realm.objects(ZipcodeModel.self).filter(NSPredicate(format: "city == %@", ""))
         }
    }
}
