import UIKit
import SnapKit

final class CustomCalendarHeaderView: UIView {
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 22)
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemPink
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemPink
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerView)
        [monthLabel, leftButton, rightButton].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        monthLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview() // 수직 중앙
            make.trailing.equalTo(monthLabel.snp.leading).offset(-16)
            make.width.height.equalTo(24)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(monthLabel.snp.trailing).offset(16)
            make.width.height.equalTo(24)
        }
    }
}
