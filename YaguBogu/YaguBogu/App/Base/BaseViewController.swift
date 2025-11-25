
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
    }
    
    func configureUI(){
    }
    
    func setupConstraints(){
    }
    
}
