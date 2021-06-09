//
//  ImageSave+CoreDataProperties.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 09/06/21.
//
//

import Foundation
import CoreData


extension ImageSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageSave> {
        return NSFetchRequest<ImageSave>(entityName: "ImageSave")
    }

    @NSManaged public var image: Data

}

extension ImageSave : Identifiable {

}
