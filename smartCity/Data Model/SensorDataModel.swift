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
      let datas = List<Data>()
}


