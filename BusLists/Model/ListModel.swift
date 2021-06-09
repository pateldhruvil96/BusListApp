//
//  ListModel.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 07/06/21.
//

import Foundation

struct ListModel:Codable{
    var metaData: MetaData
    var totalList: [SeachedItems]

    enum CodingKeys: String, CodingKey {
        case metaData = "metaData"
        case totalList = "inv"
    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metaData = try container.decode(MetaData.self, forKey: .metaData)
        self.totalList = try container.decode([SeachedItems].self, forKey: .totalList)
    }
    
}
struct MetaData: Codable {
    var destination, source: String
    var totalCount: Int
    var busLogoBaseURL: String
    var currency: String
    var minFr, maxFr: Int
    var sourceId, destinationId:Int

    enum CodingKeys1: String, CodingKey {
        case destination = "dst"
        case source = "src"
        case totalCount = "totalCount"
        case busLogoBaseURL = "blu"
        case currency = "currency"
        case sourceId = "srcid"
        case destinationId = "dstid"
        case minFr = "minFr"
        case maxFr = "maxFr"

    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys1.self)
        self.destination = try container.decode(String.self, forKey: .destination)
        self.source = try container.decode(String.self, forKey: .source)
        self.totalCount = try container.decode(Int.self, forKey: .totalCount)
        self.busLogoBaseURL = try container.decode(String.self, forKey: .busLogoBaseURL)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.sourceId = try container.decode(Int.self, forKey: .sourceId)
        self.destinationId = try container.decode(Int.self, forKey: .destinationId)
        self.minFr = try container.decode(Int.self, forKey: .minFr)
        self.maxFr = try container.decode(Int.self, forKey: .maxFr)
    }

}
struct SeachedItems: Codable{
    var source,destination: String
    var departureTime,arrivalTime:String
    var travelsName:String
    var ratingModel : Rating
    var busLogoURL: String
    var busTypeModel : BusType
    var busFair : Int
    var currency : String
    

    enum CodingKeys2: String, CodingKey {
        case source = "StdBp"
        case destination = "StdDp"
        case departureTime = "dt"
        case arrivalTime = "at"
        case travelsName = "Tvs"
        case ratingModel = "rt"
        case busLogoURL = "lp"
        case busTypeModel = "bc"
        case busFair = "minFare"
        case currency = "cur"
    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys2.self)
        self.source = try container.decode(String.self, forKey: .source)
        self.destination = try container.decode(String.self, forKey: .destination)
        self.departureTime = try container.decode(String.self, forKey: .departureTime)
        self.arrivalTime = try container.decode(String.self, forKey: .arrivalTime)
        self.travelsName = try container.decode(String.self, forKey: .travelsName)
        self.ratingModel = try container.decode(Rating.self, forKey: .ratingModel)
        self.busLogoURL = try container.decode(String.self, forKey: .busLogoURL)
        self.busTypeModel = try container.decode(BusType.self, forKey: .busTypeModel)
        self.busFair = try container.decode(Int.self, forKey: .busFair)
        self.currency = try container.decode(String.self, forKey: .currency)
    }
    init(source: String, destination: String, departureTime:String, arrivalTime:String, travelsName:String,busFair:Int, currency:String,rating:Rating,busLogoURL:String,busTypeModel:BusType) {
        self.source = source
        self.destination = destination
        self.departureTime = departureTime
        self.arrivalTime =  arrivalTime
        self.travelsName =  travelsName
        self.busFair =  busFair
        self.currency =  currency
        self.ratingModel = rating
        self.busLogoURL = busLogoURL
        self.busTypeModel = busTypeModel
      }
}
struct Rating:Codable{
    var rating:Double

    enum CodingKeys3: String, CodingKey {
        case rating = "totRt"
    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys3.self)
        self.rating = try container.decode(Double.self, forKey: .rating)
    }
    init(rating:Double){
        self.rating = rating
    }
}
struct BusType:Codable{
    var isAC, isNonAC, isSeater, isSleeper: Bool

    enum CodingKeys4: String, CodingKey{
        case isAC = "IsAc"
        case isNonAC = "IsNonAc"
        case isSeater = "IsSeater"
        case isSleeper = "IsSleeper"
    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys4.self)
        self.isAC = try container.decode(Bool.self, forKey: .isAC)
        self.isNonAC = try container.decode(Bool.self, forKey: .isNonAC)
        self.isSeater = try container.decode(Bool.self, forKey: .isSeater)
        self.isSleeper = try container.decode(Bool.self, forKey: .isSleeper)
    }
    init(isAc:Bool,isNonAC:Bool,isSeater:Bool,isSleeper:Bool){
        self.isAC = isAc
        self.isNonAC = isNonAC
        self.isSeater = isSeater
        self.isSleeper = isSleeper
    }
}
