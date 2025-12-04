
import RxSwift
import RxRelay
import RxCocoa

enum AlertAction {
    case cancel
    case confirm
}

class CustomAlertViewModel {
    let cancelButtonTapped = PublishRelay<Void>()
    let confirmButtonTapped = PublishRelay<Void>()
    
    let dismissAction = PublishRelay<AlertAction>()
    
    private var disposeBag = DisposeBag()
    
    init(){
        bind()
    }
    
    private func bind(){
        cancelButtonTapped
            .map{AlertAction.cancel}
            .bind(to: dismissAction)
            .disposed(by: disposeBag)
        
        confirmButtonTapped
            .map{AlertAction.confirm}
            .bind(to: dismissAction)
            .disposed(by: disposeBag)
        
    }
}
