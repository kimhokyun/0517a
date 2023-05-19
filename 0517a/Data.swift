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
struct DataDetail :Codable{
    var shop : ShopDetail?
}

struct ShopDetail :Codable{
    let id : Int?
    let name : String?
    let point : Double?
    let review : Int?
    let distance : String?
    let time : String?
    let imageFile : String?
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


/*
 {
   "shop": {
       "id" : 1,
       "name" : "치킨플러스-마곡방화점",
       "point" : 4.3,
       "review" : 217,
       "distance" : "1.6km",
       "time" : "50~60분",
       "imageFile": "detail1.png"
   }
 }
*/
