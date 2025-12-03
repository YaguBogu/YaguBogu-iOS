import UIKit

final class SelectGameCell: UITableViewCell{
    static let identifier = "SelectGameCell"
    
    private lazy var myTeamView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [myTeamLogo,myTeamLabel])
        view.spacing = 6
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let myTeamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let myTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFPro-Medium", size: 14)
        label.textColor = .appBlack
        return label
    }()
    
    private lazy var gameInfoView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [gameDateLabel,scoreLabel,stadiumLabel])
        view.spacing = 8
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let gameDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        label.textColor = .gray07
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.textColor = .appBlack
        return label
    }()
    
    private let stadiumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        label.textColor = .gray07
        return label
    }()
    
    private lazy var opposingTeamView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [opposingTemaLogo,opposingTeamLabel])
        view.spacing = 6
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let opposingTemaLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let opposingTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFPro-Medium", size: 14)
        label.textColor = .appBlack
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        contentView.backgroundColor = .white
        
        mainStackView.distribution = .equalCentering
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        
        [myTeamView,gameInfoView,opposingTeamView].forEach{
            mainStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints(){
        mainStackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 32, bottom: 14, right: 32))
        }
        myTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        opposingTemaLogo.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
    }
    
    func configure(with model: SelectGameCellModel){
        myTeamLabel.text = model.myTeamName
        gameDateLabel.text = model.gameDate
        scoreLabel.text = model.score
        stadiumLabel.text = model.stadium
        opposingTeamLabel.text = model.opposingTeamName
        
        myTeamLogo.image = UIImage(named: model.myTeamLogo)
        opposingTemaLogo.image = UIImage(named: model.opposingTeamLogo)
    }
    
}
