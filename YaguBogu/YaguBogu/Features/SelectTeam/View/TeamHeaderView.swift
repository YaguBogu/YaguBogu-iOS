import UIKit
import SnapKit

class TeamHeaderView: UICollectionReusableView {
    static let identifier = "TeamHeaderView"
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "응원하는 구단팀을 선택하고, 구장 날씨를 확인하세요\n한번 선택하신 구장은 변경하실 수 없습니다"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
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
