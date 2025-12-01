import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FSCalendar

final class ScheduleViewController: BaseViewController {
    
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
}
