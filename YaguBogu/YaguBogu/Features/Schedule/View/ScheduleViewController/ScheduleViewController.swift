import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FSCalendar

final class ScheduleViewController: BaseViewController, FSCalendarDelegate {
    
    private let viewModel: ScheduleViewModel
    private let calendarView: CustomCalendarView
    private let scheduleCardView = BaseScheduleCardView()
    private let noScheduleView = NoScheduleView()
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        self.calendarView = CustomCalendarView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        calendarView.didSelectDate = {[weak self] date in
            self?.updateSchedule(for: date)
        }
        
        // 초기 선택 날짜 반영
        if let today = calendarView.calendar.selectedDate {
            updateSchedule(for: today)
        }
        
        // viewModel의 gameDatesForCalendar가 바뀌면 reload
        viewModel.gameDatesForCalendar
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.calendarView.calendar.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func setConstraints() {
        [calendarView, scheduleCardView, noScheduleView].forEach { view.addSubview($0) }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(344)
            $0.width.equalTo(375)
        }
        
        scheduleCardView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        noScheduleView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    private func updateSchedule(for date: Date) {
        let calendar = Calendar.current
        
        guard let game = viewModel.allGames.value.first(where: { calendar.isDate($0.date, inSameDayAs: date) }) else {
            scheduleCardView.isHidden = true
            noScheduleView.isHidden = false
            noScheduleView.configureDateInfo(with: date)
            return
        }
        
        // 경기 있을 때
        scheduleCardView.isHidden = false
        noScheduleView.isHidden = true
        scheduleCardView.configureCardViewInfo(with: game)
    }
}
