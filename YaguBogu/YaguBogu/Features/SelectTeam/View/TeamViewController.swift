import UIKit
import CoreLocation
import RxSwift
import RxRelay
import SnapKit

class TeamViewController: BaseViewController {
    
    private var viewModel: TeamViewModel!
    
    
    init(viewModel: TeamViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.bg
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 16
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.layer.shadowColor = UIColor.appBlack.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 8
        
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor.bg
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        let labelText = "관심 야구 팀 선택"
        label.text = labelText
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        label.textColor = UIColor.appBlack
        label.textAlignment = .center
        return label
    }()
    
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        button.setTitle("선택완료", for: .normal)
        button.titleLabel?.textColor = .appWhite
        button.layer.cornerRadius = 12
        return button
    }()
    private let isLoadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isHidden = false
        return view
    }()
    
    private let indicatorLoadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind()
        viewModel.loadMergeData()
    }
    
    override func configureUI(){
        super.configureUI()
        [titleLabel].forEach{
            headerView.addSubview($0)
        }
        
        [selectButton].forEach{
            bottomView.addSubview($0)
        }
        
        [headerView,collectionView,bottomView].forEach{
            view.addSubview($0)
        }
        view.addSubview(isLoadingView)
        isLoadingView.addSubview(indicatorLoadingView)
    }
    
    override func setupConstraints(){
        super.setupConstraints()
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(bottomView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(57)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
            make.leading.trailing.equalToSuperview()
            
        }
        isLoadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicatorLoadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.teams
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.selectedIndexPath
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.isConfirmButtonState
            .asDriver()
            .drive(onNext: { [weak self] isEnabled in
                self?.selectButton.isEnabled = isEnabled
                self?.selectButton.backgroundColor = isEnabled
                ? UIColor.primary
                : UIColor.gray02
            }).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        selectButton.rx.tap
            .bind(to: viewModel.confirmButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: {[weak self] loading in
                if loading{
                    self?.isLoadingView.isHidden = false
                    self?.indicatorLoadingView.startAnimating()
                } else{
                    self?.isLoadingView.isHidden = true
                    self?.indicatorLoadingView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    func setupCollectionView(){
        collectionView.isSkeletonable = true
        
        collectionView.dataSource = self
        collectionView.register(SelectTeamCell.self, forCellWithReuseIdentifier: SelectTeamCell.identifier)
        collectionView.register(TeamHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TeamHeaderView.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0/2.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 16, bottom: 0, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.teams.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectTeamCell.identifier, for: indexPath) as? SelectTeamCell else {
            return UICollectionViewCell()
        }
        let teamInfo = viewModel.teams.value[indexPath.item]
        cell.configure(with: teamInfo)
        
        let isSelected = viewModel.selectedIndexPath.value == indexPath
        cell.selectedCell(isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TeamHeaderView.identifier,
                for: indexPath) as? TeamHeaderView else {
            return UICollectionReusableView()
        }
        
        return header
    }
}

