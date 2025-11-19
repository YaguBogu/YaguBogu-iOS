
import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController{
    
    var disposeBag = DisposeBag()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 248/255, green: 248/255, blue: 250/255, alpha: 1.0))
    }
    
    func configureUI(){
        view.addSubview(bottomView)
    }
    
    func setupConstraints(){
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
}
