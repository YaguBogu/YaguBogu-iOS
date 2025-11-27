//
//  RecordData+CoreDataProperties.swift
//  YaguBogu
//
//  Created by oww on 11/26/25.
//
//

import Foundation
import CoreData


extension RecordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordData> {
        return NSFetchRequest<RecordData>(entityName: "RecordData")
    }

    @NSManaged public var awayScore: Int64
    @NSManaged public var contentText: String?
    @NSManaged public var gameDate: String?
    @NSManaged public var homeScore: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var photoData: Data?
    @NSManaged public var stadium: String?
    @NSManaged public var title: String?
    @NSManaged public var homeTeam: String?
    @NSManaged public var awayTeam: String?

}

extension RecordData : Identifiable {

}
