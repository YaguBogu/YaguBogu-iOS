
import RxSwift
import UIKit

class CustomAlertCoordinator:BaseCoordinator{
    
    private let disposeBag = DisposeBag()
    
    private var title: String
    private var message: String
    private var cancelTitle: String?
    private var confirmTitle: String
    
    init(navigationController: UINavigationController, title: String, message: String, cancelTitle: String?, confirmTitle: String) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.confirmTitle = confirmTitle
        
        
        super.init(navigationController: navigationController)
    }
    
    func start(completion: @escaping (AlertAction) -> Void){
        let viewModel = CustomAlertViewModel()
        let alertVC = CustomAlertView(viewModel: viewModel)
        
        alertVC.setTitle(title)
        alertVC.setMessage(message)
        alertVC.setConfirmButtonText(confirmTitle)
        if let cancel = cancelTitle {
                alertVC.setCancelButtonText(cancel)
            } else {
                alertVC.hideCancelButton()
            }
        
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
