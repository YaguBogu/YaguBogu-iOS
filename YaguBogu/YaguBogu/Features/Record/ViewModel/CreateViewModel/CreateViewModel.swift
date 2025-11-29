import RxSwift
import RxRelay
import RxCocoa

final class CreateViewModel{
    private let disposeBag = DisposeBag()
    
    let cancelButtonTapped = PublishRelay<Void>()
    let confirmButtonTapped = PublishRelay<Void>()
    let selectGameButtonTapped = PublishRelay<Void>()
    let navigateToSelectGame = PublishSubject<Void>()
    
    let selectedGameText = BehaviorRelay<String>(value: "선택")
    let gameSelected = PublishSubject<SelectGameCellModel>()
    
    let isConfirmButtonState = BehaviorRelay<Bool>(value: false)
    let dismiss = PublishRelay<Void>()
    
    
    
    init(){
        bind()
    }
    
    private func bind(){
        cancelButtonTapped
            .bind(to: dismiss)
            .disposed(by: disposeBag)
        
        selectGameButtonTapped
            .bind(to: navigateToSelectGame)
            .disposed(by: disposeBag)
        
        gameSelected
            .map{"\($0.myTeamName) vs \($0.opposingTeamName)"}
            .bind(to: selectedGameText)
            .disposed(by: disposeBag)
    }
    
}
