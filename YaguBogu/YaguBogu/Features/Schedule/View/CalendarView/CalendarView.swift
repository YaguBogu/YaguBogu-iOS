import UIKit
import SnapKit
import FSCalendar
import RxSwift
import RxCocoa

final class CalendarView: UIView {
    let headerView = CustomCalendarHeaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "Cell")
        calendar.delegate = self
        calendar.dataSource = self
        setConstraints()
    }
    
    private let calendarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
        
    }()
    
    private let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        
        calendar.headerHeight = 0
        calendar.calendarHeaderView.isHidden = true
        
        // 요일
        calendar.appearance.weekdayFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        calendar.appearance.weekdayTextColor = .gray05

        // 오늘 날짜 표시
        calendar.appearance.todayColor = .primary
        calendar.appearance.todaySelectionColor = .primary
        
        // 좌우 스크롤해서 달력 넘기기
        calendar.scrollEnabled = false
        
        return calendar
    }()

    private func setConstraints() {
        [headerView, calendar].forEach { calendarContainerView.addSubview($0)}
        addSubview(calendarContainerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(344)
        }
        
        calendarContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CalendarView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    // dot 몇 개 표시할건지
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }

}



#Preview {
    CalendarView()
}
