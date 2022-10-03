//
//  ZipcodeModel.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import RealmSwift

class ZipcodeModel: Object, ObjectKeyIdentifiable {
    @objc dynamic var zipcode = "N/A"
    @objc dynamic var city = "N/A"
}
