import UIKit

class HomeViewController: BaseViewController {
    
    private let viewModel: HomeViewModel
    
    private let teamName = UILabel()
    private let cityName = UILabel()
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureUI() {
        super.configureUI()
        [teamName, cityName].forEach{
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        teamName.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        cityName.snp.makeConstraints{ make in
            make.top.equalTo(teamName.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.selectedTeam
            .asDriver()
            .drive(onNext: { [weak self] team in
                self?.teamName.text = team.name
                self?.cityName.text = team.city
                print("홈 화면으로 전달된 팀: \(team)")
            })
            .disposed(by: disposeBag)
    }
    
}

