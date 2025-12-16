import UIKit
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

final class StadiumSelectViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // 선택된 구장을 홈 코디네이터한테 전달하는 릴레이
    let selectedStadium = PublishRelay<StadiumInfo>()

    // 표시할 구장 리스트 (구장겹침이 있어서 총 9개)
    private let stadiums: [StadiumInfo] = [
        StadiumInfo(
            name: "서울종합운동장(잠실야구장)",
            city: "서울",
            latitude: 37.5131,
            longitude: 127.0710,
            address: "서울특별시 송파구 올림픽로 25 서울종합운동장"
        ),
        StadiumInfo(
            name: "대전한화생명이글스파크",
            city: "대전",
            latitude: 36.3171,
            longitude: 127.4290,
            address: "대전 중구 대종로 373 한화생명이글스파크"
        ),
        StadiumInfo(
            name: "광주기아챔피언스필드",
            city: "광주",
            latitude: 35.1683,
            longitude: 126.8893,
            address: "광주 북구 서림로 10 무등종합경기장"
        ),
        StadiumInfo(
            name: "고척스카이돔",
            city: "서울",
            latitude: 37.4982,
            longitude: 126.8671,
            address: "서울 구로구 경인로 430"
        ),
        StadiumInfo(
            name: "수원KT위즈파크",
            city: "수원",
            latitude: 37.2996,
            longitude: 127.0095,
            address: "경기 수원시 장안구 경수대로 893 수원종합운동장(주경기장)"
        ),
        StadiumInfo(
            name: "사직야구장",
            city: "부산",
            latitude: 35.1940,
            longitude: 129.0615,
            address: "부산 동래구 사직로 55-32"
        ),
        StadiumInfo(
            name: "창원NC파크",
            city: "창원",
            latitude: 35.2220,
            longitude: 128.5790,
            address: "경남 창원시 마산회원구 삼호로 63"
        ),
        StadiumInfo(
            name: "대구삼성라이온즈파크",
            city: "대구",
            latitude: 35.8410,
            longitude: 128.6812,
            address: "대구 수성구 야구전설로 1 대구삼성라이온즈파크"
        ),
        StadiumInfo(
            name: "인천SSG랜더스필드",
            city: "인천",
            latitude: 37.4350,
            longitude: 126.6909,
            address: "인천 미추홀구 매소홀로 618"
        )
    ]


    // UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구장 선택"
        label.font = UIFont.sdGothic(.headlineBody, weight: .regular)
        label.textColor = .appBlack
        label.textAlignment = .center
        return label
    }()

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupTableView()
        bindTable()
    }

    private func setupUI() {
        view.backgroundColor = .appWhite
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(33)
            make.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 54
        tableView.separatorStyle = .none
    }

    private func bindTable() {
        Observable.just(stadiums)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, item, cell in
                cell.textLabel?.text = "\(item.name), \(item.city)"
                cell.textLabel?.font = UIFont.sdGothic(.headlineBody, weight: .regular)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(StadiumInfo.self)
            .bind { [weak self] stadium in
                self?.selectedStadium.accept(stadium)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

