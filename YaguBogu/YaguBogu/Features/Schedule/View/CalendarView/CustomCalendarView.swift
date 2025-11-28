import UIKit
import SnapKit
import FSCalendar
import RxSwift
import RxCocoa

final class CustomCalendarView: UIView {

    let headerView = CustomCalendarHeaderView()
    let calendar = FSCalendar()
    
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCalendar()
        setupActions()
        setupLayout()
        updateHeaderMonthLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCalendarView {
    
    // 달력 관련 기본 설정
    private func setupCalendar() {
        // 커스텀 셀 연결
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "CustomCalendarCell")
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .month
        calendar.headerHeight = 0
        calendar.calendarHeaderView.isHidden = true
        
        calendar.scrollEnabled = false
        calendar.appearance.weekdayFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        calendar.appearance.weekdayTextColor = .gray
        
        calendar.placeholderType = .none
        
        let today = Date()
        calendar.select(today)
        calendar.reloadData()
        
        calendar.appearance.todayColor = .clear
        calendar.appearance.todaySelectionColor = .clear

        calendar.appearance.selectionColor = .clear
        calendar.appearance.titleSelectionColor = .clear
        
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    private func setupLayout() {
        [headerView, calendar].forEach { addSubview($0) }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }
    
    private func setupActions() {
        headerView.leftButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(by: -1)
            })
        headerView.rightButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(by: 1)
            })
            .disposed(by: disposeBag)
    }
}

extension CustomCalendarView {
    
    private func updateHeaderMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM월"
        headerView.monthLabel.text = formatter.string(from: calendar.currentPage)
        headerView.monthLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 22)
    }

    private func moveCurrentPage(by monthDelta: Int) {
        var dateComponents = DateComponents()
        dateComponents.month = monthDelta
        
        if let newPage = Calendar.current.date(byAdding: dateComponents, to: calendar.currentPage) {
            calendar.setCurrentPage(newPage, animated: true)
            updateHeaderMonthLabel()
        }
    }
}

extension CustomCalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    // 커스텀 셀 반환 설정
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell
        return cell
    }
}
