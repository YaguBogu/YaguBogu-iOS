import UIKit
import SnapKit
import FSCalendar
import RxSwift
import RxCocoa

final class CustomCalendarView: UIView {

    let headerView = CustomCalendarHeaderView()
    let calendar = FSCalendar()
    
    private let viewModel: ScheduleViewModel
    private let disposeBag = DisposeBag()
    
    var didSelectDate: ((Date) -> Void)?
    var didTapMonthButton: (() -> Void)?
    
    init(frame: CGRect = .zero, viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        bindViewModel()
        setupCalendar()
        setupActions()
        setupLayout()
        updateHeaderMonthLabel()
    }

    private func bindViewModel() {
        viewModel.gameDatesForCalendar
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.calendar.reloadData()
            })
            .disposed(by: disposeBag)
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
        calendar.appearance.weekdayTextColor = .gray05
        
        calendar.placeholderType = .none
        
//        let today = Date()
//        calendar.select(today)
        
        // today를 260327로 설정
        let today20260327 = viewModel.today20260327
        calendar.select(today20260327)
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
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(280)
        }
    }
    
    private func setupActions() {
        headerView.leftButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(by: -1)
                self?.didTapMonthButton?()
            })
            .disposed(by: disposeBag)
        
        headerView.rightButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveCurrentPage(by: 1)
                self?.didTapMonthButton?()

            })
            .disposed(by: disposeBag)
    }
}

extension CustomCalendarView {
    
    private func updateHeaderMonthLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM월"
        headerView.monthLabel.text = formatter.string(from: calendar.currentPage)
    }

    private func moveCurrentPage(by monthDelta: Int) {
        var dateComponents = DateComponents()
        dateComponents.month = monthDelta
        
        if let newPage = Calendar.current.date(byAdding: dateComponents, to: calendar.currentPage) {
            calendar.setCurrentPage(newPage, animated: true)
            updateHeaderMonthLabel()
        }
    }
    
    func skipToDay() {
        let today = viewModel.today20260327
        calendar.select(today)
        calendar.setCurrentPage(today, animated: true)
        updateHeaderMonthLabel()
        didSelectDate?(today)
    }
}

extension CustomCalendarView: FSCalendarDelegate, FSCalendarDataSource {
    
    // 커스텀 셀 반환 설정
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CustomCalendarCell", for: date, at: position) as! CustomCalendarCell
        return cell
    }
  
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = cell as? CustomCalendarCell else { return }
        
        let today = viewModel.today20260327
        cell.isToday = Calendar.current.isDate(today, inSameDayAs: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let dateString = formatter.string(from: date)
        
        cell.hasDot = viewModel.gameDatesForCalendar.value.contains(dateString)
        cell.configureAppearance()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        didSelectDate?(date)
    }
}
