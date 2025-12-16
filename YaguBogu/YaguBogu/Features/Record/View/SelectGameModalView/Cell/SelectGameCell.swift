import UIKit

final class SelectGameCell: UITableViewCell{
    static let identifier = "SelectGameCell"
    
    private lazy var awayTeamView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [awayTeamLogo,awayTeamLabel])
        view.spacing = 6
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let awayTeamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .sfPro(.caption1, weight: .medium)
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
        label.font = .sdGothic(.caption2, weight: .semibold)
        label.textColor = .gray07
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .sfPro(.title3, weight: .semibold)
        label.textColor = .gray09
        label.numberOfLines = 1
        return label
    }()
    
    private let stadiumLabel: UILabel = {
        let label = UILabel()
        label.font = .sdGothic(.caption2, weight: .medium)
        label.textColor = .gray07
        return label
    }()
    
    private lazy var homeTeamView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [homeTeamLogo,homeTeamLabel])
        view.spacing = 6
        view.axis = .vertical
        view.alignment = .center
        return view
    }()
    
    private let homeTeamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .sfPro(.caption1, weight: .medium)
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
        
        mainStackView.distribution = .equalSpacing
        
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        
        [awayTeamView,gameInfoView,homeTeamView].forEach{
            mainStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints(){
        mainStackView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 32, bottom: 14, right: 32))
        }
        awayTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        homeTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
    }
    
    func configure(with model: SelectGameCellModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: model.gameDate) else {return}
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "ko_KR")
        dayFormatter.dateFormat = "MM.dd (E)"
        awayTeamLabel.font = .sdGothic(.caption1, weight: .semibold)
        homeTeamLabel.font = .sdGothic(.caption1, weight: .semibold)
        
        awayTeamLabel.text = model.awayTeamName
        gameDateLabel.text = dayFormatter.string(from: date)
        
        scoreLabel.text = model.score
        
        stadiumLabel.text = model.stadium
        homeTeamLabel.text = model.homeTeamName
        
        awayTeamLogo.image = UIImage(named: model.awayTeamLogo)
        homeTeamLogo.image = UIImage(named: model.homeTeamLogo)
        
        if model.isCancelled{
            scoreLabel.font = .sdGothic(.headlineBody, weight: .semibold)
            scoreLabel.textColor = .gray07
        }else {
            scoreLabel.font = .sfPro(.title3, weight: .semibold)
            scoreLabel.textColor = .gray09
        }
        
    }
    
}
