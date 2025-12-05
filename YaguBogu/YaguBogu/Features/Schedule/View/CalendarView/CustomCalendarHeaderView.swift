import UIKit
import SnapKit

final class CustomCalendarHeaderView: UIView {
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 22)
        label.textColor = .appBlack
        label.textAlignment = .center
        label.backgroundColor = .bg
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "leftIcon"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .bg
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rightIcon"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .bg
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg
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
            make.centerY.equalToSuperview()
            make.trailing.equalTo(monthLabel.snp.leading).offset(-16)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(monthLabel.snp.trailing).offset(16)
        }
    }
}
