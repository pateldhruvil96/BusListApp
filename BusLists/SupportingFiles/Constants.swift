//
//  Constants.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 07/06/21.
//

import Foundation


//Base url:
let BASEURL = "https://api.jsonbin.io"

//End Point
enum EndPoint:String{
    case route = "/b/6093c95293e0ce40806d8a1d"
}

//Xib's name:
let BUSLISTCELL = "BusListTableViewCell"
let FILTERCELL = "FilterTableViewCell"


let HEADERARRAY = ["Sort By","Bus Type"]
let TITLEARRAY = [
    ["User's Rating","Early Departure","Late Departure","Cheapest Fare"],
    ["AC","Non AC","Seater","Sleeper"]
]
let IMAGEARRAY = [
    ["FilterRating","EarlyTime","LateTime","Currency"],
    ["Ac","NonAc","Seater","Sleeper"]
]

//Entity Name:
let BUSLISTENTITYNAME = "BusList"
let IMAGESAVEENTITYNAME = "ImageSave"

//Userdefault's Name:
let SORTBYTITLE = "sortByTitle"
let BUSTYPESET = "busTypeSet"

