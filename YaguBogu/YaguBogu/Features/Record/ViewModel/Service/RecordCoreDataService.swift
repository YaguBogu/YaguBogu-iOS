
import CoreData
import RxSwift
import RxRelay


final class RecordCoreDataService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
        self.context = context
    }

    
    func fetchRecords() -> Observable<[RecordData]> {
        
        return Observable.create { [weak self] observer in
            let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "gameDate", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                let records = try self?.context.fetch(fetchRequest)
                observer.onNext(records ?? [])
            } catch {
                observer.onError(error)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
