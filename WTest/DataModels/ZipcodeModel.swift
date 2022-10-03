//
//  ZipcodeModel.swift
//  WTest
//
//  Created by Nuno Ferro on 28/09/2022.
//

import Foundation
import RealmSwift

class ZipcodeModel: Object, ObjectKeyIdentifiable, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted dynamic var zipcode = "N/A"
    @Persisted dynamic var city = "N/A"
}
