
import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController{
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
        view.backgroundColor = .bg
        hideKeyboardWhenTappedAround()
    }
    
    func configureUI(){
    }
    
    func setupConstraints(){
    }
    
}
extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
