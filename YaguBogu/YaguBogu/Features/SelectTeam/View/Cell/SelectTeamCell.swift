
import Foundation
import UIKit
import SnapKit

class SelectTeamCell: UICollectionViewCell{
    static let identifier = "SelectTeamCell"
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var teamNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .appBlack
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.textColor = .gray06
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [teamNameLabel, cityLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(logoImage)
        mainStackView.addArrangedSubview(labelStackView)
    }
    
    private func setupConstraints(){
        
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.width).multipliedBy(0.4)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        
    }
    
    func configure(with team: TeamInfo){
        let transTeamLabel = team.name
        let koreanTeamLabel = BaseBallNameTranslator.getKoreanName(for: transTeamLabel)
        logoImage.image = UIImage(named: team.selectTeamLogo)
        teamNameLabel.text = koreanTeamLabel
        cityLabel.text = team.city
    }
    
    func selectedCell(_ selected: Bool){
        if selected{
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.primary.cgColor
            contentView.backgroundColor = .primary.withAlphaComponent(0.1)
            
        } else{
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.gray01.cgColor
            contentView.backgroundColor = .appWhite
        }
    }
}
