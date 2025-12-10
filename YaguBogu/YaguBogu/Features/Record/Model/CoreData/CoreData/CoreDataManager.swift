import CoreData
import RxSwift


final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let coreDataStack = CoreDataStack.shared
    
    private init() {}
    
    func saveRecord(title: String, contentText: String, photoData: String, game: SelectGameCellModel, myTeam: TeamInfo) -> Completable {
        return Completable.create { completable in
            
            let context = self.coreDataStack.persistentContainer.viewContext
            let record = RecordData(context: context)
            
            record.id = UUID()
            
            record.title = title
            record.contentText = contentText
            record.photoData = photoData
            
            
            record.gameDate = game.gameDate
            record.stadium = game.stadium
            record.homeTeam = game.homeTeamName
            record.awayTeam = game.awayTeamName
            record.homeTeamId = Int32(game.homeTeamID)
            record.awayTeamId = Int32(game.awayTeamID)
            
            record.homeScore = Int32(game.homeTeamScore)
            record.awayScore = Int32(game.awayTeamScore)
            
            record.setValue(myTeam.id, forKey: "myTeamId")
            record.setValue(myTeam.name, forKey: "selectedTeam")
            
            
            do {
                try context.save()
                print("context.save() 성공")
                
            } catch {
                print("CoreData 저장 실패")
            }
            
            completable(.completed)
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
    }
    
    func fetchRecords() -> Single<[RecordData]> {
        return Single.create { single in
            
            let context = self.coreDataStack.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: "gameDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let records = (try? context.fetch(fetchRequest)) ?? []
            
            single(.success(records))
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
    }
}
