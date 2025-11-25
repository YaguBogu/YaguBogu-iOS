import UIKit
import SnapKit

final class NothingRecordView: UIView {
    
    let notingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "nothinglogo")
        return image
    }()
    
    let notingTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.numberOfLines = 2
        let labelText = "등록된 직관 기록이 없습니다\n직관을 등록해 보세요"
        label.text = labelText
        label.setSpacingInPixels(text: labelText, spacingInPx: 18)
        label.textColor = .gray03
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notingImage, notingTextLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
