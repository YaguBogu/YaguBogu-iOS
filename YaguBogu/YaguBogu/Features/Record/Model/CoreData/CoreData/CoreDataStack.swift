import CoreData

final class CoreDataStack{
    static let shared = CoreDataStack()
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecordData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
}

//배포시 제거
extension CoreDataStack {
    
    func addDummyData() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            
            if count == 0 {
                createDummyData(context: context)
            } else {
            }
        } catch {
            print("데이터 확인 실패")
        }
    }
    
    private func createDummyData(context: NSManagedObjectContext) {
        
        for i in 1...6 {
            let newRecord = RecordData(context: context)
            
            newRecord.id = UUID()
            
            newRecord.title = "test\(i)"
            newRecord.gameDate = "2025-03-2\(i)"
            
            newRecord.homeTeam = "LG"
            newRecord.awayTeam = "KIA"
            newRecord.stadium = "stadium"
            
            
            newRecord.contentText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            newRecord.homeScore = Int64(Int.random(in: 0...5))
            newRecord.awayScore = Int64(Int.random(in: 0...5))
        
            
            
        }
        
        saveContext()
    }
}
