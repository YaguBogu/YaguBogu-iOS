import UIKit
import SnapKit

final class StadiumLocationView: UIView {

    
    private let shadowContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.shadowColor = UIColor(red: 1, green: 0.45, blue: 0.46, alpha: 0.04).cgColor
        v.layer.shadowOffset = CGSize(width: 4, height: 4)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 4
        return v
    }()
    
    private let mainContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
        return v
    }()
    
    // 상단 지도(웹뷰 자리)
    private let mapContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    // 지금은 웹뷰 자리니까 임시 이미지 넣어둠
    private let placeholderImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "stadiumMap")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // 하단 정보 박스
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "구장 위치"
        lb.textColor = .appBlack
        lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return lb
    }()
    
    private let addressLabel: UILabel = {
        let lb = UILabel()
        lb.text = "서울 송파구 올림픽로 25 서울종합운동장"
        lb.textColor = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
        lb.numberOfLines = 2
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    
    let openButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("지도 열기", for: .normal)
        btn.backgroundColor = .primary
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 14)!
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    func updateAddress(_ text: String) {
        addressLabel.text = text
    }
}


private extension StadiumLocationView {
    func setupUI() {
        addSubview(shadowContainer)
        shadowContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        shadowContainer.addSubview(mainContainer)
        mainContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        mainContainer.addSubview(mapContainer)
        mapContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(268)
        }
        
        mapContainer.addSubview(placeholderImageView)
        placeholderImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        // 하단 info 영역
        let locationInfoContainer = UIView()
        locationInfoContainer.backgroundColor = .appWhite
        mainContainer.addSubview(locationInfoContainer)

        locationInfoContainer.snp.makeConstraints {
            $0.top.equalTo(mapContainer.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(98)
        }

        // titleLabel
        locationInfoContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        // address + button 행 컨테이너
        let addressRow = UIStackView(arrangedSubviews: [addressLabel, openButton])
        addressRow.axis = .horizontal
        addressRow.spacing = 12
        addressRow.alignment = .center
        addressRow.distribution = .fill

        locationInfoContainer.addSubview(addressRow)
        addressRow.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        addressLabel.snp.makeConstraints {
            $0.height.equalTo(36)
        }

        openButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(39)
        }

    }
}

