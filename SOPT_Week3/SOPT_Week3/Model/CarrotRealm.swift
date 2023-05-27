//
//  CarrotRealm.swift
//  SOPT_Week3
//
//  Created by uiskim on 2023/05/27.
//

import UIKit
import RealmSwift

class CarrotRealm: Object {
    
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var product: String
    @Persisted var place: String
    @Persisted var time: String
    @Persisted var price: Int
    
    convenience init(id: Int, product: String, place: String, time: String, price: Int) {
        self.init()
        self.id = id
        self.product = product
        self.place = place
        self.time = time
        self.price = price
    }
}
