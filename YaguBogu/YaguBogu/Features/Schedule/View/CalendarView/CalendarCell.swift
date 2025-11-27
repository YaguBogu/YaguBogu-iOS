import UIKit
import SnapKit
import FSCalendar

class CustomCalendarCell: FSCalendarCell {
    
    var isToday: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.configureAppearance()
        }
    }
    
    private lazy var selectionLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.insertSublayer(selectionLayer, at: 0)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
}
