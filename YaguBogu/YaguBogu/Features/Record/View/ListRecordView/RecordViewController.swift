import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CoreData

final class RecordViewController: BaseViewController {
    
    private let viewModel: RecordViewModel
    
    private let emptyView = EmptyRecordView()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = UIColor.bg
        
        collectionView.register(ListRecordCell.self, forCellWithReuseIdentifier: ListRecordCell.identifier)
        return collectionView
    }()
    
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floatingbutton"), for: .normal)
        button.layer.shadowColor = UIColor.appBlack.cgColor
        button.layer.shadowOpacity = 0.16
        button.layer.shadowRadius = 16
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadMergeData()
    }
    
    override func configureUI() {
        super.configureUI()
        
        [collectionView,emptyView,floatingButton].forEach{
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        emptyView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        floatingButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-26)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-26)
        }
        
        
    }
    
    private func bind(){
        viewModel.recordList
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(
                cellIdentifier: ListRecordCell.identifier,
                cellType: ListRecordCell.self
            )) { index, data, cell in
                cell.configure(with: data)
            }
            .disposed(by: disposeBag)
        
        viewModel.recordList
            .map { $0.isEmpty }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEmpty in
                self?.emptyView.isHidden = !isEmpty
                self?.collectionView.isHidden = isEmpty
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(RecordData.self)
            .bind(to: viewModel.navigateToDetail)
            .disposed(by: disposeBag)
            
    }
    
    private func createLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/2.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0/2.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(11)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 11
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16 , leading: 16, bottom: 0, trailing: 16)
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
