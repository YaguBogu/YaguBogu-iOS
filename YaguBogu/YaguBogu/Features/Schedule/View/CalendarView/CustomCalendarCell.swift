import UIKit
import FSCalendar
import SnapKit

class CustomCalendarCell: FSCalendarCell {
    
    private let circleLayer = CAShapeLayer()
    private let borderLayer = CAShapeLayer()
    private let dotView = UIView()

    override init (frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        // 원 레이어 구성
        circleLayer.fillColor = UIColor.primary.cgColor
        circleLayer.isHidden = true
        contentView.layer.insertSublayer(circleLayer, at: 0)

        // 원 테두리
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.primary.cgColor
        borderLayer.lineWidth = 1
        borderLayer.isHidden = true
        contentView.layer.addSublayer(borderLayer)
        
        // dot
        dotView.backgroundColor = .secondary
        dotView.layer.cornerRadius = 3
        contentView.addSubview(dotView)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // 셀 전체 frame 기준 (title + dot 포함)
        let diameter: CGFloat = 40
        let circleFrame = CGRect(
            x: (bounds.width - diameter) / 2,  // 셀의 중앙
            y: (bounds.height - diameter) / 2,  // 셀 중앙
            width: diameter,
            height: diameter
        )

        circleLayer.path = UIBezierPath(ovalIn: circleFrame).cgPath
        borderLayer.path = UIBezierPath(ovalIn: circleFrame).cgPath

        // dot 위치 (셀 전체 기준)
        dotView.frame = CGRect(
            x: bounds.midX - 3,
            y: circleFrame.maxY - 12,
            width: 6,
            height: 6
        )
    }

    override func configureAppearance() {
        super.configureAppearance()
        
        circleLayer.isHidden = true
        borderLayer.isHidden = true
        dotView.backgroundColor = .secondary
        circleLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor

        if dateIsToday {
            // 오늘 날짜
            circleLayer.isHidden = false
            circleLayer.fillColor = UIColor.primary.withAlphaComponent(1.0).cgColor
            borderLayer.isHidden = true
            dotView.backgroundColor = .appWhite
            titleLabel.textColor = .appWhite
            titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        } else if isSelected {
            // 선택된 날짜
            circleLayer.isHidden = false
            circleLayer.fillColor = UIColor.primary.withAlphaComponent(0.3).cgColor
            borderLayer.isHidden = true
            dotView.backgroundColor = .appWhite
            titleLabel.textColor = .primary
            titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        } else {
            // 나머지 날짜
            circleLayer.isHidden = true
            borderLayer.isHidden = true
            titleLabel.textColor = .appBlack
            dotView.backgroundColor = .secondary
            titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
}
