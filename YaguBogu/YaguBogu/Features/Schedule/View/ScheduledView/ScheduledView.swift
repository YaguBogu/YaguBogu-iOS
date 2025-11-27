//import UIKit
//import SnapKit
//
//final class ScheduledView: BaseScheduleCardView {
//    
//    // 홈 팀
//    private lazy var homeTeamVstack = makeTeamStackView.TeamStackView (
//        image: UIImage(named: "SelectSSG"),
//        name: "SSG"
//    )
//    
//    // 원정 팀
//    private lazy var awayTeamVstack = makeTeamStackView.TeamStackView (
//        image: UIImage(named: "SelectLG"),
//        name: "LG"
//    )
//    
//    // 시간 및 구장
//    private let timeHomeStadiumStackView = TimeStadiumStackView.timeStadiumStackView (
//        time: "18 : 30",
//        stadium: "SSG 랜더스 필드"
//    )
//        
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setConstraints() {
//        
//        // 배경 뷰 추가
//        [timeHomeStadiumStackView, homeTeamVstack, awayTeamVstack].forEach { addSubview($0) }
//        backgroundView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.equalTo(343)
//            $0.height.equalTo(134)
//        }
//        
//        // 시간 + 구장 스택뷰 추가
//        backgroundView.addSubview(timeHomeStadiumStackView)
//        timeHomeStadiumStackView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
//        
//        // 홈팀 스택뷰 추가
//        backgroundView.addSubview(homeTeamVstack)
//        homeTeamVstack.snp.makeConstraints {
//            $0.leading.equalTo(timeHomeStadiumStackView.snp.trailing).offset(62)
//            $0.centerY.equalTo(timeHomeStadiumStackView)
//        }
//        
//        // 원정팀 스택뷰 추가
//        backgroundView.addSubview(awayTeamVstack)
//        awayTeamVstack.snp.makeConstraints {
//            $0.trailing.equalTo(timeHomeStadiumStackView.snp.leading).offset(-62)
//            $0.centerY.equalTo(timeHomeStadiumStackView)
//        }
//        
//    }
//}
//
//#Preview {
//    ScheduledView()
//}
