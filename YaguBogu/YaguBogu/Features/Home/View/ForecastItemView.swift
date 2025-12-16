import UIKit
import SnapKit

final class ForecastItemView: UIView {

    private let timeLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }

    private func setupUI() {
        // 시간
        timeLabel.font = UIFont.sdGothic(.caption1, weight: .medium)
        timeLabel.textColor = .appBlack
        timeLabel.textAlignment = .center

        // 아이콘
        iconView.contentMode = .scaleAspectFit

        // 온도
        tempLabel.font = UIFont.sdGothic(.title3, weight: .semibold)
        tempLabel.textColor = .appBlack
        tempLabel.textAlignment = .center
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [timeLabel, iconView, tempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6

        stack.setContentHuggingPriority(.required, for: .horizontal)
        stack.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }

        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }

        tempLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
    }

    func configure(time: String, iconName: String, temp: Int) {
        timeLabel.text = time
        iconView.image = UIImage(named: iconName)
        tempLabel.text = "\(temp)°"
    }
}

