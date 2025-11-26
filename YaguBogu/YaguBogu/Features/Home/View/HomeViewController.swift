import UIKit
import RxSwift
import RxGesture
import RxCocoa
import SnapKit

class HomeViewController: BaseViewController {
    
    weak var coordinator: HomeCoordinator?
    
    private let viewModel: HomeViewModel
    
    private let teamName = UILabel()
    private let cityName = UILabel()
    
    private let tempLabel = UILabel()
    private let stadiumLabel = UILabel()
    private let rainLabel = UILabel()
    private let humidityLabel = UILabel()
    private let windLabel = UILabel()

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
        [teamName, cityName, stadiumLabel, tempLabel, rainLabel, humidityLabel, windLabel]
            .forEach { view.addSubview($0) }
        
        stadiumLabel.isUserInteractionEnabled = true
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        teamName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        cityName.snp.makeConstraints { make in
            make.top.equalTo(teamName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        stadiumLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        rainLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(rainLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        windLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }

    private func bind() {
        let output = viewModel.output
        
        // 팀명, 도시
        output.teamName
            .drive(teamName.rx.text)
            .disposed(by: disposeBag)
        
        output.cityName
            .drive(cityName.rx.text)
            .disposed(by: disposeBag)
        
        // 선택된 구장 타이틀
        output.stadiumTitle
            .drive(stadiumLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 날씨 정보 텍스트
        output.temperatureText
            .drive(tempLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.rainText
            .drive(rainLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.humidityText
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.windText
            .drive(windLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 스타디움 라벨 탭 -> 구장 선택 화면 표시 (코디네이터한테 넘김)
        stadiumLabel.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showStadiumSelect()
            }
            .disposed(by: disposeBag)
    }
}

