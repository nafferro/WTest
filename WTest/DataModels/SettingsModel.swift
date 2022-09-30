//
//  SettingsModel.swift
//  WTest
//
//  Created by Nuno Ferro on 29/09/2022.
//

import Foundation
import RealmSwift

class SettingsModel: Object {
    @objc dynamic var fileLoaded = false
    @objc dynamic var databaseLoaded = false
}
