//
//  Data.swift
//  smartCity
//
//  Created by shick on 16.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import Foundation
import RealmSwift

class SensorDataModel: Object {
    
      @objc dynamic var id: Int = 0
      @objc dynamic var name  : String = ""
      @objc dynamic var value : String = ""
      let parkplatzValue = List<String>()
    
}


//class ParkPlatz: Object {
//    @objc dynamic var value = false
//}

