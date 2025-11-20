
import Foundation
import UIKit


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
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .semibold)
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
        let stack = UIStackView(arrangedSubviews: [logoImage, labelStackView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.addSubview(mainStackView)
    }
    
    private func configureLayout(){
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
        logoImage.image = UIImage(named: team.teamLogo)
        teamNameLabel.text = koreanTeamLabel
        cityLabel.text = team.city
    }
    
    func selectedCell(_ selected: Bool){
        if selected{
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor(red: 255/255,green: 114/255, blue: 116/255, alpha: 1.0).cgColor
            contentView.backgroundColor = UIColor(red: 255/255, green: 114/255, blue: 116/255, alpha: 0.1)
            
        } else{
            contentView.layer.borderWidth = 0.0
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.backgroundColor = .white
        }
    }
}
