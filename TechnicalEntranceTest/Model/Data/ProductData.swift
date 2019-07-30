//
//  ProductData.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import Foundation
import RealmSwift



class GroupProductType: Object{
    var title:Int = 0
    var Detail:[Info] = []
    
}
struct Product:Decodable{
    var DS:[Info]
}

struct Info:Decodable {
    var ID:Int = -1
    var Name:String = ""
    var TypeDisplay:Int = -1
    var Cost:String = ""
    var TimeDelivery:String = ""
    var Rate:String = ""
    var Payment:Int = -1
    var Url:String = ""
    var Person:String = ""
    var Description:String = ""
    var Ingredient:String = ""
    var Weight:String = ""
    var Extras:[ExtrasDetail]
    var ListType:[ListTypeDetail]
    
    init(ID: Int, Name:String, TypeDisplay:Int, Cost:String, TimeDelivery:String , Rate:String, Payment:Int, Url:String, Person:String, Description:String,Ingredient:String, Weight:String,Extras:[ExtrasDetail], ListType:[ListTypeDetail]) {
        self.ID = ID
        self.Name = Name
        self.TypeDisplay = TypeDisplay
        self.Cost = Cost
        self.TimeDelivery = TimeDelivery
        self.Rate = Rate
        self.Payment = Payment
        self.Url = Url
        self.ListType = ListType
        self.Extras = Extras
        self.Person = Person
        self.Weight = Weight
        self.Ingredient = Ingredient
        self.Description = Description
    }
}
struct ExtrasDetail:Decodable {
    
    var ID: Int = -1
    var Name : String = ""
    var Cost: String = ""
    init (Name: String, ID:Int, Cost: String){
        self.ID = ID
        self.Name = Name
        self.Cost = Cost
        
    }
}
struct ListTypeDetail:Decodable {

    var ID: Int = -1
    var Primary : Bool = false
    var Name: String = ""
    init (Name: String, ID:Int, Primary: Bool){
        self.ID = ID
        self.Name = Name
        self.Primary = Primary
        
    }
}
