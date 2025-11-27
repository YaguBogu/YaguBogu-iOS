import UIKit
import RxSwift

final class RecordCoordinator: BaseCoordinator {
    
    private let team: TeamInfo
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        
        let recordViewModel = RecordViewModel(team: team)
        let listViewModel = ListViewModel()
        
        let viewController = RecordViewController(
            viewModel: recordViewModel,
            listViewModel: listViewModel
        )
        viewController.navigationItem.title = "나의 직관 기록"
        
        listViewModel.navigateToDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] recordData in
                
                self?.showDetail(data: recordData)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    
    private func showDetail(data: RecordData) {
        let detailVM = DetailRecordViewModel(data: data)
        let detailVC = DetailRecordModalView(viewModel: detailVM)
        
        if let sheet = detailVC.sheetPresentationController {
            
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { context in
                return context.maximumDetentValue - 1
            }
            
            sheet.preferredCornerRadius = 26
            sheet.detents = [customDetent]
            sheet.selectedDetentIdentifier = customDetent.identifier
            sheet.prefersGrabberVisible = true
        }
        
        
        
        navigationController.present(detailVC, animated: true)
    }
}
