//
//  GenericModel.swift
//  smartCity
//
//  Created by shick on 18.07.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import Foundation
import RealmSwift

class GenericModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name  : String = ""
    let datas = List<Data>()
    //  the value unit °C for example
}
