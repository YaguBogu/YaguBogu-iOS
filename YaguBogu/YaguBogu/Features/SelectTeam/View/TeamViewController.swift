import UIKit
import CoreLocation
import RxSwift
import RxRelay
import SnapKit

class TeamViewController: BaseViewController {
    private let viewModel = TeamViewModel()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(cgColor: CGColor(red: 248/255, green: 248/255, blue: 250/255, alpha: 1.0))
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor(cgColor: CGColor(red: 248/255, green: 248/255, blue: 250/255, alpha: 1.0))
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 야구 팀 선택"
        label.textAlignment = .center
        return label
    }()
    
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택완료", for: .normal)
        button.backgroundColor = UIColor(cgColor: CGColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1.0))
        button.layer.cornerRadius = 12
        return button
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
    }
    
    override func setupConstraints(){
        super.setupConstraints()
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(57)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
            make.leading.trailing.equalToSuperview()
            
        }
    }
    
    private func bind() {
        viewModel.teams
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func setupCollectionView(){
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
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0 , leading: 12, bottom: 0, trailing: 12)
        
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


#Preview{
    TeamViewController()
}
