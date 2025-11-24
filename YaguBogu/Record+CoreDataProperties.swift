//
//  Record+CoreDataProperties.swift
//  YaguBogu
//
//  Created by oww on 11/24/25.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var awayScore: Int64
    @NSManaged public var awayTeamLogo: String?
    @NSManaged public var contentText: String?
    @NSManaged public var gameDate: Date?
    @NSManaged public var gameInfo: String?
    @NSManaged public var homeTeamLogo: String?
    @NSManaged public var matchStatus: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var stadium: String?
    @NSManaged public var title: String?
    @NSManaged public var homeScore: Int64
    @NSManaged public var id: UUID?

}

extension Record : Identifiable {

}
