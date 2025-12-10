
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
    
    private let dimView = GradientView()
    
    
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
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var currentPhotoData: String?
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundPicture.image = UIImage(named: "Emptylogo")
        matchStatus.image = nil
        titleLabel.text = nil
        gameDate.text = nil
        currentPhotoData = nil
    }
    
    func configureUI() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .bg
        [backgroundPicture, dimView, matchStatus,bottomStackView].forEach{
            contentView.addSubview($0)
        }
    }
    func setupConstraints() {
        backgroundPicture.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dimView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundPicture)
        }
        
        matchStatus.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }
        bottomStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    
    private func setupGradient(){
        dimView.gradientLayer.colors = [
            UIColor(white: 0, alpha: 0.04).cgColor,
            UIColor(white: 0, alpha: 1.0).cgColor
        ]
        
        dimView.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        dimView.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
    }
    
    func configure(with data: RecordData){
        titleLabel.text = data.title
        gameDate.text = data.gameDate
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        gameDate.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
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
            matchStatus.image = nil
        }
        
        if let photoFileName = data.photoData, !photoFileName.isEmpty {
            let image = loadImageCoreData(fileName: photoFileName)
            
            self.backgroundPicture.image = image ?? UIImage(named: "Emptylogo")
            
        } else {
            
            self.backgroundPicture.image = UIImage(named: "Emptylogo")
        }
        
    }
    
}


class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
}
