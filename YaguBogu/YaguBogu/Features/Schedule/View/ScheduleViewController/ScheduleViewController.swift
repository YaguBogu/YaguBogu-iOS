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
    private var toolTip: UIImageView?
    
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
        
        calendarView.didTapMonthButton = { [weak self] in
            self?.showToolTip()}
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
    
    private func showToolTip() {
        if UserDefaults.standard.bool(forKey: "didShowScheduleToolTip") { return }
        
        if toolTip != nil { return }
        
        let toolTipImageView: UIImageView = {
            let image = UIImageView(image: UIImage(named: "toolTip"))
            image.alpha = 0
            image.snp.makeConstraints {
                $0.width.equalTo(100)
                $0.height.equalTo(40)
            }
            return image
        }()
    
        guard let tabBar = tabBarController?.tabBar else { return }
        
        view.addSubview(toolTipImageView)
        
        // 경기 일정 탭
        let index = 1  // 두 번째 탭의 중앙 X
        let tabCount = tabBar.items?.count ?? 1
        let itemWidth = tabBar.bounds.width / CGFloat(tabCount)
        let centerX = itemWidth * CGFloat(index) + itemWidth / 2
        
        toolTipImageView.snp.makeConstraints {
            $0.bottom.equalTo(tabBar.snp.top).offset(-4)
            $0.centerX.equalToSuperview().offset(centerX - tabBar.bounds.width / 2)
            
            toolTipImageView.alpha = 0
            UIView.animate(withDuration: 0.25) {
                toolTipImageView.alpha = 1
            }
        }
        UserDefaults.standard.set(true, forKey: "didShowScheduleToolTip")
    }
}
