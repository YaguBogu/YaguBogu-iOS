import UIKit

struct CustomTabBarItem {
    let title: String
    let defaultImage: UIImage?
    let selectedImage: UIImage?
}

final class CustomTabBarView: UIView {

    var onSelectIndex: ((Int) -> Void)?

    private var items: [CustomTabBarItem] = []
    private var buttons: [UIButton] = []

    private let stackView = UIStackView()

    private let backgroundView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }

    private func setupUI() {
        backgroundColor = .clear

        // 모서리 설정
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 24
        backgroundView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]

        backgroundView.layer.masksToBounds = false

        // 그림자
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: -2)
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.04 

        addSubview(backgroundView)
        backgroundView.addSubview(stackView)

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }


    private func setupLayout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // 버튼 스택
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }


    func configure(items: [CustomTabBarItem]) {
        self.items = items

        // 기존 버튼 제거
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // 버튼 생성
        for (index, item) in items.enumerated() {
            let button = makeButton(item: item, index: index)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        setSelected(index: 0)
    }

    func setSelected(index: Int) {
        for (i, button) in buttons.enumerated() {
            let isSelected = (i == index)
            let item = items[i]

            var config = button.configuration

            // 아이콘
            config?.image = isSelected ? item.selectedImage : item.defaultImage

            // 라벨 + 아이콘 색상
            config?.baseForegroundColor = isSelected ? .primary : .gray03

            button.configuration = config
        }
    }


    private func makeButton(item: CustomTabBarItem, index: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        config.imagePadding = 4
        config.title = item.title

        config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font =
                    UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                    ?? UIFont.systemFont(ofSize: 14, weight: .medium)
                return outgoing
            }

        let button = UIButton(configuration: config)
        button.tag = index
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return button
    }


    @objc private func didTap(_ sender: UIButton) {
        onSelectIndex?(sender.tag)
    }
}
