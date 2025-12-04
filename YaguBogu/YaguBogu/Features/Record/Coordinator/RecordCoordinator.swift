import UIKit
import RxSwift


final class RecordCoordinator: BaseCoordinator {
    
    private let team: TeamInfo
    private let disposeBag = DisposeBag()
    private let extraTeamsJson: ExtraTeamsJsonService
    private let gameInfoService: RecordGameInfoService
    
    private weak var createViewModel: CreateViewModel?
    
    init(navigationController: UINavigationController, team: TeamInfo, extraTeamsJson: ExtraTeamsJsonService) {
        self.team = team
        self.extraTeamsJson = extraTeamsJson
        self.gameInfoService = RecordGameInfoService()
        super.init(navigationController: navigationController)
    }
    override func start() {
        super.start()
        let coreDataService = RecordCoreDataService()
        
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
        self.createViewModel = createVM
        let createVC = CreateRecordView(viewModel: createVM)
        let navigationController = UINavigationController(rootViewController: createVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        createVM.dismiss
            .subscribe(onNext: {[weak navigationController] in
                navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        createVM.navigateToSelectGame
            .subscribe(onNext: {[weak self] in
                self?.showSelectGame()
            })
            .disposed(by: disposeBag)
        
        self.navigationController.present(navigationController, animated: true)
    }
    
    private func showSelectGame() {
        let extraTeamsData: [TeamExtra] = extraTeamsJson.loadExtraTeams()
        
        let selectVM = SelectGameViewModel(
            selectedTeam: self.team,
            extraTeams: extraTeamsData,
            gameService: self.gameInfoService
        )
        
        let selectVC = SelectGameModalView(viewModel: selectVM)
        
        selectVM.selectedGame
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] selectedGame in
                self?.createViewModel?.gameSelected.onNext(selectedGame)
                selectVC.dismiss(animated: true,completion: nil)
            })
            .disposed(by: disposeBag)
        
        if let sheet = selectVC.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { context in
                return context.maximumDetentValue - 70
            }
            
            sheet.preferredCornerRadius = 26
            sheet.detents = [customDetent]
            sheet.selectedDetentIdentifier = customDetent.identifier
            sheet.prefersGrabberVisible = true
        }
        
        self.navigationController.presentedViewController?.present(selectVC, animated: true)
    }
}

