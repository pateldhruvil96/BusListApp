//
//  BusList+CoreDataProperties.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 08/06/21.
//
//

import Foundation
import CoreData


extension BusList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusList> {
        return NSFetchRequest<BusList>(entityName: "BusList")
    }

    @NSManaged public var travelsName: String
    @NSManaged public var source: String
    @NSManaged public var destination: String
    @NSManaged public var sourceTime: String
    @NSManaged public var destinationTime: String
    @NSManaged public var fare: Int64
    @NSManaged public var logoImage: Data
    @NSManaged public var busType: String
    @NSManaged public var rating: Double
    @NSManaged public var currency: String

}

extension BusList : Identifiable {

}
