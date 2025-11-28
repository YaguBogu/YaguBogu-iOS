import RxSwift
import RxRelay
import RxCocoa

final class CreateViewModel{
    private let disposeBag = DisposeBag()
    
    let cancelButtonTapped = PublishRelay<Void>()
    let confirmButtonTapped = PublishRelay<Void>()
    
    let isConfirmButtonState = BehaviorRelay<Bool>(value: false)
    let dismiss = PublishRelay<Void>()
    
    init(){
        bind()
    }
    
    private func bind(){
        cancelButtonTapped
            .bind(to: dismiss)
            .disposed(by: disposeBag)
    }
    
}
