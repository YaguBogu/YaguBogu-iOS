import UIKit
import SnapKit

final class NoScheduleView: UIView {
    
    private let bottomNoScheduleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    
    // 선택한 날짜 라벨
    let scheduleDateLabel: UILabel = {
        let label = UILabel()
//        label.text = "날짜 정보 미정"
        
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        label.backgroundColor = .white
        return label
    }()
    
    private let noScheduleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Emptylogo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let noScheduleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.text = "경기 일정이 없습니다."
        label.textColor = .gray04
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var VStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [noScheduleImage, noScheduleTextLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    private func setConstraints() {
        addSubview(bottomNoScheduleView)
        [scheduleDateLabel, VStackView].forEach { bottomNoScheduleView.addSubview($0) }

        bottomNoScheduleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scheduleDateLabel.snp.makeConstraints {
            $0.leading.top.equalTo(16)
            $0.height.equalTo(22)
        }
        
        VStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(103)
            $0.height.equalTo(74)
        }
        
        noScheduleTextLabel.snp.makeConstraints {
            $0.height.equalTo(12)
        }
        
        noScheduleImage.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    func configureDateInfo(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 경기 일정"
        scheduleDateLabel.text = formatter.string(from: date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
