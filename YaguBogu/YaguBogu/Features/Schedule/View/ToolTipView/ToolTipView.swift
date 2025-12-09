import UIKit
import SnapKit

final class ToolTipView: UIView {
    
    private let arrowWidth: CGFloat = 15
    private let arrowHeight: CGFloat = 9
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘로 돌아가기"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        label.textColor = .appWhite
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toolTipView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(toolTipView)
        toolTipView.addSubview(textLabel)
        
        toolTipView.snp.makeConstraints {
            $0.width.equalTo(99)
            $0.height.equalTo(34)
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-arrowHeight)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(-12)
            $0.trailing.equalToSuperview().offset(12)
        }
    }
    
    // 화살표 그리기
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let arrowPath = UIBezierPath()
        let centerX = rect.width / 2
        
        let leftPoint = CGPoint(x: centerX - arrowWidth, y: rect.height - arrowHeight)
        let rightPoint = CGPoint(x: centerX + arrowWidth, y: rect.height - arrowHeight)
        let bottomPoint = CGPoint(x: centerX, y: rect.height)
        
        arrowPath.move(to: leftPoint)
        arrowPath.addLine(to: rightPoint)
        arrowPath.addLine(to: bottomPoint)
        
        let arrowLayer = CAShapeLayer()
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.fillColor = UIColor.primary.cgColor
        
        layer.addSublayer(arrowLayer)
    }
}
