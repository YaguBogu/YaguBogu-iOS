import UIKit
import SnapKit

final class PermissionBottomSheetView: UIView {

    private let viewModel: PermissionBottomSheetViewModel

    private let handleBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 196/255, green: 196/255, blue: 199/255, alpha: 1)
        view.layer.cornerRadius = 2.5
        return view
    }()

    let closeButton: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        btn.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        btn.tintColor = UIColor(red: 0x38/255, green: 0x38/255, blue: 0x38/255, alpha: 1)
        return btn
    }()

    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        view.layer.cornerRadius = 25
        return view
    }()

    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.tintColor = .appBlack
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        label.textColor = .appBlack
        return label
    }()

    private let mainDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        return label
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()

    private let subDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.numberOfLines = 0
        return label
    }()

    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        btn.backgroundColor = .primary
        btn.layer.cornerRadius = 12
        return btn
    }()


    init(viewModel: PermissionBottomSheetViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupLayout()
        bind(viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }


    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 35
        clipsToBounds = true

        addSubview(handleBar)
        addSubview(closeButton)
        addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(mainDescriptionLabel)
        addSubview(divider)
        addSubview(subDescriptionLabel)
        addSubview(confirmButton)
    }


    private func setupLayout() {


        handleBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(36)
            $0.height.equalTo(5)
        }


        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(36)
        }


        iconContainer.snp.makeConstraints {
            $0.top.equalTo(handleBar.snp.bottom).offset(76)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(55)
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(26)
            $0.height.equalTo(22)
        }


        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainer.snp.top)
            $0.leading.equalTo(iconContainer.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualTo(closeButton.snp.leading).offset(-16)
        }


        mainDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-24)
        }


        divider.snp.makeConstraints {
            $0.top.equalTo(iconContainer.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }


        subDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }


        confirmButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(subDescriptionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(57)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }


    private func bind(_ viewModel: PermissionBottomSheetViewModel) {
        titleLabel.text = viewModel.titleText
        mainDescriptionLabel.text = viewModel.descriptionText
        subDescriptionLabel.text = viewModel.subDescriptionText
    }
}

