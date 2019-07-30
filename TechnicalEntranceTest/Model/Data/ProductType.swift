//
//  ProductType.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import Foundation

struct ProductType:Decodable{
    var DS:[InfoProductType]
}
struct InfoProductType:Decodable {
    var ID: Int = -1
    var Logo : String = ""
    var Name: String = ""
    init (Name: String, ID:Int, Logo: String){
        self.ID = ID
        self.Name = Name
        self.Logo = Logo
    }
}
