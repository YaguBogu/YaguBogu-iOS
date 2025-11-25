import UIKit
import RxSwift
import RxRelay
import RxCocoa
import CoreData


final class ListViewModel {
    
    private var disposeBag = DisposeBag()
    
    let recordList = BehaviorRelay<[RecordData]>(value: [])
    let navigateToDetail = PublishSubject<RecordData>()
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
        self.context = context
        fetchData()
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "gameDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let records = try context.fetch(fetchRequest)
            
            recordList.accept(records)
            
        } catch {
            print("CoreData Fetch Error: \(error)")
        }
    }
    
}
