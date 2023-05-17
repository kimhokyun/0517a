//
//  Data.swift
//  0517a
//
//  Created by hokyun Kim on 2023/05/17.
//

import Foundation

struct Data :Codable{
    var shopList : [Shop]
}

struct Shop :Codable{
    let id : Int
    let category : String
    let name : String
    let point : Double
    let review : Int
    let adFlag : String
    let imageFile : String
}

/*
 "id" : 1,
 "category" : "CK",
 "name" : "치킨플러스-마곡방화점",
 "point" : 4.3,
 "review" : 217,
 "adFlag" : "N",
 "imageFile": "thumb1.png"
 */
