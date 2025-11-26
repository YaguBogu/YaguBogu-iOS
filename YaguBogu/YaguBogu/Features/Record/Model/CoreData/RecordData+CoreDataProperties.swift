
import Foundation
import CoreData


extension RecordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordData> {
        return NSFetchRequest<RecordData>(entityName: "RecordData")
    }

    @NSManaged public var awayScore: Int64
    @NSManaged public var awayTeamLogo: String?
    @NSManaged public var contentText: String?
    @NSManaged public var gameDate: String?
    @NSManaged public var gameInfo: String?
    @NSManaged public var homeTeamLogo: String?
    @NSManaged public var matchStatus: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var stadium: String?
    @NSManaged public var title: String?
    @NSManaged public var homeScore: Int64
    @NSManaged public var id: UUID?

}

extension RecordData : Identifiable {

}
