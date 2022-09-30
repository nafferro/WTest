//
//  ZipcodeModel.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import RealmSwift

class ZipcodeModel: Object {
    @objc dynamic var zipcode = "N/A"
    @objc dynamic var zipcodeExtension = "N/A"
    @objc dynamic var city = "N/A"
}
