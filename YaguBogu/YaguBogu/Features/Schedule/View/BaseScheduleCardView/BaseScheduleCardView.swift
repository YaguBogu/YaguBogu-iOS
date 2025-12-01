import UIKit
import SnapKit

// 경기 여부에 따라 점수 or 시간으로 바뀌어야 함
enum MatchCardInfo {
    case score(score: String, stadium: String)
    case time(time: String, stadium: String)
}

final class BaseScheduleCardView: UIView {
    
    let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg
        return view
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.gray01.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.02
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    let scheduleDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        return label
    }()
    
    // away, home 넣는 스택뷰
    private let teamsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.backgroundColor = .appWhite
        return stack
    }()
    
    // 외부에서 가져온 score, time 정보 설정을 위해
    private var cardInfoView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(contentContainerView)
        [scheduleDateLabel, backgroundView].forEach { contentContainerView.addSubview($0) }
        backgroundView.addSubview(teamsStackView)
        
        contentContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scheduleDateLabel.snp.makeConstraints {
            $0.leading.top.equalTo(16)
            $0.height.equalTo(22)
        }
        
        backgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343)
            $0.height.equalTo(134)
            $0.top.equalTo(scheduleDateLabel.snp.bottom).offset(10)
        }
        
        teamsStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension BaseScheduleCardView {
    // 팀 스택뷰 생성
    static func teamStackView(image: UIImage?, name: String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.width.height.equalTo(50) }
        
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        
        return stack
    }
    
    // 점수 표시 (끝난 경기)
    static func scoreStadiumStackView(score: String, stadium: String ) -> UIStackView {
        let scoreLabel = UILabel()
        scoreLabel.text = score
        scoreLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        scoreLabel.textColor = .gray09
        
        let stadiumLabel = UILabel()
        stadiumLabel.text = stadium
        stadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        stadiumLabel.textColor = .gray07
        
        let vStack = UIStackView(arrangedSubviews: [scoreLabel, stadiumLabel])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        return vStack
    }
    
    // 시간 표시 (예정된 경기)
    static func timeStadiumStackView(time: String, stadium: String) -> UIStackView {
        // 시간 라벨
        let timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        timeLabel.textColor = .gray09
        
        // 구장 라벨
        let stadiumLabel = UILabel()
        stadiumLabel.text = stadium
        stadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        stadiumLabel.textColor = .gray07
        
        // 시간 및 구장 스택뷰
        let vStack = UIStackView(arrangedSubviews: [timeLabel, stadiumLabel])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        vStack.backgroundColor = .appWhite
        
        return vStack
    }
    
    func configureCardViewInfo(with game: Game) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 경기 일정"
        scheduleDateLabel.text = formatter.string(from: game.date)
        
        teamsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        cardInfoView?.removeFromSuperview()
        
        let away = BaseScheduleCardView.teamStackView(image: UIImage(named: "Onboarding1"), name: BaseBallNameTranslator.getKoreanName(for: game.awayTeamName))
        let home = BaseScheduleCardView.teamStackView(image: UIImage(named: "Onboarding2"), name: BaseBallNameTranslator.getKoreanName(for: game.homeTeamName))
        [away, home].forEach { teamsStackView.addArrangedSubview($0) }
        
        // 점수, 시간 표시
        if let result = game.result, game.status == .finished {
            let center = BaseScheduleCardView.scoreStadiumStackView(
                score: "\(result.awayTeamScore) : \(result.homeTeamScore)",
                stadium: game.homeTeamName
            )
            teamsStackView.insertArrangedSubview(center, at: 1)
            cardInfoView = center
        } else {
            let center = BaseScheduleCardView.timeStadiumStackView(
                time: game.time,
                stadium: game.homeTeamName
            )
            teamsStackView.insertArrangedSubview(center, at: 1)
            cardInfoView = center
        }
    }
}
