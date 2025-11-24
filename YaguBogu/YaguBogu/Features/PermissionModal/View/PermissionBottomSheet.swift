import UIKit
import SnapKit

final class PermissionBottomSheet: UIViewController {

    private let viewModel: PermissionBottomSheetViewModel

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.alpha = 0
        return view
    }()

    private let sheetView: PermissionBottomSheetView
    
    private let sheetHeight: CGFloat


    private var sheetInitialY: CGFloat = 0

    init(viewModel: PermissionBottomSheetViewModel) {
        self.viewModel = viewModel
        self.sheetView = PermissionBottomSheetView(viewModel: viewModel)

        let figmaHeightRatio: CGFloat = 1126.0 / 2622.0
        self.sheetHeight = UIScreen.main.bounds.height * figmaHeightRatio

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupGesture()

        sheetView.closeButton.addTarget(self, action: #selector(animateDismiss), for: .touchUpInside)
        sheetView.confirmButton.addTarget(self, action: #selector(animateDismiss), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresent()
    }


    private func setupLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { $0.edges.equalToSuperview() }

        view.addSubview(sheetView)
        sheetView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(sheetHeight)
            $0.bottom.equalToSuperview().offset(sheetHeight)
        }
    }


    private func setupGesture() {
        // 딤드뷰 클릭하면 닫힘
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDimmedTap))
        dimmedView.addGestureRecognizer(tap)

        // 핸들바랑 전체 시트 제스처
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        sheetView.addGestureRecognizer(panGesture)
    }

    @objc private func handleDimmedTap() {
        animateDismiss()
    }


    private func animatePresent() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 1
        }

        sheetView.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut
        ) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func animateDismiss() {
        sheetView.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(self.sheetHeight)
        }

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseIn
        ) {
            self.view.layoutIfNeeded()
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    // 핸들팬 제스처
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translationY = gesture.translation(in: view).y

        switch gesture.state {
        case .changed:
            // 아래로만 이동
            if translationY > 0 {
                sheetView.transform = CGAffineTransform(translationX: 0, y: translationY)
            }

        case .ended:
            if translationY > 120 {
                animateDismiss()
            } else {
                // 원래 자리로 복귀
                UIView.animate(withDuration: 0.2) {
                    self.sheetView.transform = .identity
                }
            }

        default: break
        }
    }

}

