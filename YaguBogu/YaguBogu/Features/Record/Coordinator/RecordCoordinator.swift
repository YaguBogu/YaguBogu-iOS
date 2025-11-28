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
        let coreDataService = RecordCoreDataService()
        let gameInfoService = RecordGameInfoService()
        
        let recordViewModel = RecordViewModel(
            team: team,
            recordStorage: coreDataService,
            gameInfoService: gameInfoService
        )
        
        let viewController = RecordViewController(
            viewModel: recordViewModel
        )
        viewController.navigationItem.title = "나의 직관 기록"
        
        recordViewModel.navigateToDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] recordData in
                
                self?.showDetail(data: recordData)
            })
            .disposed(by: disposeBag)
        
        recordViewModel.navigateToCreate
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                self?.showCreate()
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
    
    private func showCreate(){
        let createVM = CreateViewModel()
        let createVC = CreateRecordView(viewModel: createVM)
        let navigationController = UINavigationController(rootViewController: createVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        createVM.dismiss
            .subscribe(onNext: {[weak navigationController] in
                navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        self.navigationController.present(navigationController, animated: true)
    }
}
