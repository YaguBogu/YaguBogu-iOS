
import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController{
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
    }
    
    func configureUI(){
        
    }
    
    func setupConstraints(){
        
    }
    
}
