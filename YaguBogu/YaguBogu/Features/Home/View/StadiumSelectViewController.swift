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
            name: "서울종합운동장(잠실 야구장)",
            city: "서울",
            latitude: 37.5131,
            longitude: 127.0710
        ),
        StadiumInfo(
            name: "한화생명 이글스파크",
            city: "대전",
            latitude: 36.3171,
            longitude: 127.4290
        ),
        StadiumInfo(
            name: "광주기아챔피언스필드",
            city: "광주",
            latitude: 35.1683,
            longitude: 126.8893
        ),
        StadiumInfo(
            name: "고척스카이돔",
            city: "서울",
            latitude: 37.4982,
            longitude: 126.8671
        ),
        StadiumInfo(
            name: "수원KT위즈파크",
            city: "수원",
            latitude: 37.2996,
            longitude: 127.0095
        ),
        StadiumInfo(
            name: "사직야구장",
            city: "부산",
            latitude: 35.1940,
            longitude: 129.0615
        ),
        StadiumInfo(
            name: "창원NC파크",
            city: "창원",
            latitude: 35.2220,
            longitude: 128.5790
        ),
        StadiumInfo(
            name: "대구삼성라이온즈파크",
            city: "대구",
            latitude: 35.8410,
            longitude: 128.6812
        ),
        StadiumInfo(
            name: "인천 SSG 랜더스필드",
            city: "인천",
            latitude: 37.4350,
            longitude: 126.6909
        )
    ]


    // UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구장 선택"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
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
                cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
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

