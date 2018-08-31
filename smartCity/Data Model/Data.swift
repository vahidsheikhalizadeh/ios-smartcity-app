//
//  Data.swift
//  smartCity
//
//  Created by shick on 18.07.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var value : String = ""
    
    var parentCategotry1 = LinkingObjects(fromType: SensorDataModel.self, property: "datas")
    
    var parentCategotry2 = LinkingObjects(fromType: GenericModel.self, property: "data")
}


