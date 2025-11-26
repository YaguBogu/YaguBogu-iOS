import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ScheduleViewController: BaseViewController {
    
    private let viewModel: ScheduleViewModel
    
    private let teamNameLabel = UILabel()
    private let teamScheduleLabel = UILabel()
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        bind()
    }
    
    override func configureUI() {
        super.configureUI()
        [teamNameLabel, teamScheduleLabel].forEach{
            view.addSubview($0)
        }
        teamScheduleLabel.numberOfLines = 0
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        teamNameLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        teamScheduleLabel.snp.makeConstraints{ make in
            make.top.equalTo(teamNameLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.selectedTeam
            .map { BaseBallNameTranslator.getKoreanName(for: $0.name) }
            .bind(to: teamNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.game
            .asDriver()
            .drive(onNext: { [weak self] game in
                guard let self = self else { return }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
                
                let calendar = Calendar.current
                guard let startDate = dateFormatter.date(from: "2025-03-08"),
                      let endDate = dateFormatter.date(from: "2025-03-22") else {
                    self.teamScheduleLabel.text = "날짜 변환 실패"
                    return
                }
                
                var dates: [Date] = []
                var currentDate = startDate
                while currentDate <= endDate {
                    dates.append(currentDate)
                    if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                        currentDate = nextDate
                    } else {
                        currentDate = endDate.addingTimeInterval(1)
                    }
                }
                
                let gameTexts = dates.map { date -> String in
                    if let gameOfDay = game.first(where: { calendar.isDate($0.date, inSameDayAs: date) }) {
                        let status = gameOfDay.status == .finished ? "종료" : "경기 취소"

                        let homeTeamName = BaseBallNameTranslator.getKoreanName(for: self.viewModel.selectedTeam.value.name)
                        let awayTeamName = BaseBallNameTranslator.getKoreanName(for: gameOfDay.awayTeamName)
                        
                        var scoreText = ""
                        if let result = gameOfDay.result {
                            
                            if gameOfDay.isMyTeamHome {
                                let myTeamScore = result.homeTeamScore
                                let awayTeamScore = result.awayTeamScore
                                scoreText = "\(awayTeamScore) : \(myTeamScore)"
                            } else {
                                let myTeamScore = result.awayTeamScore
                                let awayTeamScore = result.homeTeamScore
                                scoreText = "\(myTeamScore) : \(awayTeamScore)"
                            }
                        }
                        else {
                            scoreText = gameOfDay.time
                        }
                        
                        let matchup = gameOfDay.isMyTeamHome
                        ? "\(awayTeamName) vs \(homeTeamName)"
                        : "\(homeTeamName) vs \(awayTeamName)"
                        
                        return "\(dateFormatter.string(from: date)) - \(matchup) - \(status) - \(scoreText)"
                    } else {
                        return "\(dateFormatter.string(from: date)) - 경기 없음"
                    }
                }
                self.teamScheduleLabel.text = gameTexts.joined(separator: "\n")
            })
            .disposed(by: disposeBag)
    }
}
