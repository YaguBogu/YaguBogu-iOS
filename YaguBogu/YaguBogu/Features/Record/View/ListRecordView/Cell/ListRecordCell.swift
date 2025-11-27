
import UIKit
import SnapKit

enum MatchResult: String {
    case win = "TypeWin"
    case lose = "TypeLose"
    case draw = "TypeDraw"
    
    init?(myTeamId: Int, homeTeamId: Int, awayTeamId: Int, homeScore: Int, awayScore: Int) {
        
        if myTeamId == homeTeamId {
            if homeScore > awayScore {
                self = .win
            } else if homeScore < awayScore {
                self = .lose
            } else {
                self = .draw
            }
            
        } else if myTeamId == awayTeamId {
            if awayScore > homeScore {
                self = .win
            } else if awayScore < homeScore {
                self = .lose
            } else {
                self = .draw
            }
        } else {
            return nil
        }
    }
}

class ListRecordCell: UICollectionViewCell{
    static let identifier = "ListRecordCell"
    
    private var backgroundPicture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "Emptylogo")
        return view
    }()
    
    private var matchStatus: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "경기장 야경"
        label.font = UIFont(name: "SFPro-Semibold", size: 17)
        label.textColor = .white
        return label
    }()
    
    private var gameDate: UILabel = {
        let label = UILabel()
        label.text = "yyyy.mm.dd"
        label.font = UIFont(name: "SFPro-Semibold", size: 12)
        label.textColor = .gray04
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, gameDate])
        stackView.axis = .vertical
        stackView.spacing = 7
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundPicture.image = UIImage(named: "Emptylogo")
    }
    
    func configureUI() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        self.backgroundView = backgroundPicture
        [matchStatus,bottomStackView].forEach{
            contentView.addSubview($0)
        }
    }
    func setupConstraints() {
        matchStatus.snp.makeConstraints{ make in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(8)
        }
        
        bottomStackView.snp.makeConstraints{ make in
            make.bottom.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configure(with data: RecordData){
        if let photoData = data.photoData, let image = UIImage(data: photoData) {
            backgroundPicture.image = image
        } else {
            backgroundPicture.image = UIImage(named: "Emptylogo")
        }
        titleLabel.text = data.title
        gameDate.text = data.gameDate
        
        let myTeamId = Int(data.myTeamId)
        let homeTeamId = Int(data.homeTeamId)
        let awayTeamId = Int(data.awayTeamId)
        let homeScore = Int(data.homeScore)
        let awayScore = Int(data.awayScore)
        
        let result = MatchResult(
            myTeamId: myTeamId,
            homeTeamId: homeTeamId,
            awayTeamId: awayTeamId,
            homeScore: homeScore,
            awayScore: awayScore
        )
        
        if let matchResult = result {
            matchStatus.image = UIImage(named: matchResult.rawValue)
        } else {
            matchStatus.image = UIImage(named: "Emptylogo")
        }
    }
    
}
