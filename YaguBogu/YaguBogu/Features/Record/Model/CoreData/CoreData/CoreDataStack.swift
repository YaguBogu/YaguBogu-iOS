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
            newRecord.title = "테스트\(i)"
            newRecord.homeScore = Int64(Int.random(in: 0...5))
            newRecord.awayScore = Int64(Int.random(in: 0...5))
            newRecord.gameDate = "2025-03-2\(i)"
            
        }
        
        saveContext()
    }
}
