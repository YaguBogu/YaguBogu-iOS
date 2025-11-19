import RxSwift
import RxCocoa

final class SplashViewModel {

    // 화면이 끝났다는 신호를 방출함
    let finishTrigger = PublishRelay<Void>()
    
    // splashDidFinish는 스플래시 뷰컨트롤러에서 쓰임
    func splashDidFinish() {
        finishTrigger.accept(())
    }
}

