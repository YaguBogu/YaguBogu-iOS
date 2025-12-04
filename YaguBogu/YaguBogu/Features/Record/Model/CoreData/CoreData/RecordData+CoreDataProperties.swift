

import Foundation
import CoreData


extension RecordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordData> {
        return NSFetchRequest<RecordData>(entityName: "RecordData")
    }

    @NSManaged public var awayScore: Int32
    @NSManaged public var contentText: String?
    @NSManaged public var gameDate: String?
    @NSManaged public var homeScore: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var photoData: String?
    @NSManaged public var stadium: String?
    @NSManaged public var title: String?
    @NSManaged public var homeTeam: String?
    @NSManaged public var awayTeam: String?
    @NSManaged public var selectedTeam: String?
    @NSManaged public var myTeamId: Int32
    @NSManaged public var homeTeamId: Int32
    @NSManaged public var awayTeamId: Int32
}

extension RecordData : Identifiable {

}
