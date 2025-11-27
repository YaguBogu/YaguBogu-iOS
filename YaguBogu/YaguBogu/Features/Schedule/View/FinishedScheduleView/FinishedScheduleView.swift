//import UIKit
//import SnapKit
//
//final class FinishedScheduleView: BaseScheduleCardView {
//
////    // 홈 팀
////    private lazy var homeTeamVstack = makeTeamStackView.TeamStackView (
////        image: UIImage(named: "SelectSSG"),
////        name: "SSG"
////    )
////    
////    // 원정 팀
////    private lazy var awayTeamVstack = makeTeamStackView.TeamStackView (
////        image: UIImage(named: "SelectLG"),
////        name: "LG"
////    )
////    
////    // 시간 및 구장
////    private let scoreHomeStadiumStackView = ScoreStadiumStackView.scoreStadiumStackView(
////        score: " 5 : 6",
////        stadium: "SSG 랜더스 필드") 
////        
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        setConstraints()
////    }
////    
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////    
////    private func setConstraints() {
////
////        // 배경 뷰 추가
////        [scoreHomeStadiumStackView, homeTeamVstack, awayTeamVstack].forEach { addSubview($0) }
////        
////        backgroundView.snp.makeConstraints {
////            $0.center.equalToSuperview()
////            $0.width.equalTo(343)
////            $0.height.equalTo(134)
////        }
////        
////        // 결과 + 구장 스택뷰 추가
////        backgroundView.addSubview(scoreHomeStadiumStackView)
////        scoreHomeStadiumStackView.snp.makeConstraints {
////            $0.center.equalToSuperview()
////        }
////        
////        // 홈팀 스택뷰 추가
////        backgroundView.addSubview(homeTeamVstack)
////        homeTeamVstack.snp.makeConstraints {
////            $0.leading.equalTo(scoreHomeStadiumStackView.snp.trailing).offset(62)
////            $0.centerY.equalTo(scoreHomeStadiumStackView)
////        }
////        
////        // 원정팀 스택뷰 추가
////        backgroundView.addSubview(awayTeamVstack)
////        awayTeamVstack.snp.makeConstraints {
////            $0.trailing.equalTo(scoreHomeStadiumStackView.snp.leading).offset(-62)
////            $0.centerY.equalTo(scoreHomeStadiumStackView)
////        }
////        
////    }
//
//}
//
//#Preview {
//    FinishedScheduleView()
//}
