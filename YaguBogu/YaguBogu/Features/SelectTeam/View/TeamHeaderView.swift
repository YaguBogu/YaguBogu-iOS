import UIKit
import SnapKit

class TeamHeaderView: UICollectionReusableView {
    static let identifier = "TeamHeaderView"
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo", size: 14)
        label.numberOfLines = 0
        let labelText = "응원하는 구단팀을 선택하고, 구장 날씨를 확인하세요\n한번 선택하신 구장은 변경하실 수 없습니다"
        label.text = labelText
        label.setSpacingInPixels(text: labelText, spacingInPx: 18)
        label.textColor = .gray04
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 16, right: 24))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
