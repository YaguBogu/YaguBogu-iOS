
import RxSwift
import UIKit

class CustomAlertCoordinator:BaseCoordinator{
    
    private let disposeBag = DisposeBag()
    
    private var title: String
    private var message: String
    
    init(navigationController: UINavigationController, title: String, message: String) {
        self.title = title
        self.message = message
        super.init(navigationController: navigationController)
    }
    
    func start(completion: @escaping (AlertAction) -> Void){
        let viewModel = CustomAlertViewModel()
        let alertVC = CustomAlertView(viewModel: viewModel)
        
        alertVC.setTitle(title)
        alertVC.setMessage(message)
        
        viewModel.dismissAction
            .subscribe(onNext: { [weak self] action in
                guard let self = self else { return }
                
                self.navigationController.dismiss(animated: true)
                
                completion(action)
            })
            .disposed(by: disposeBag)
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        navigationController.present(alertVC, animated: true)
    }
}
