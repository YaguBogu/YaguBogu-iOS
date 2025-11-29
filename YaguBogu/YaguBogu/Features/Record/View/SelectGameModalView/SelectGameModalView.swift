
import UIKit

final class SelectGameModalView: BaseViewController{
    private var viewModel: SelectGameViewModel
    
    
    init(viewModel: SelectGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerView = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "경기 선택"
        label.textColor = .appBlack
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .appWhite
        tableView.register(SelectGameCell.self, forCellReuseIdentifier: SelectGameCell.identifier)
        tableView.rowHeight = 112
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        bind()
        viewModel.fetchGameList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func configureUI() {
        super.configureUI()
        [headerView, tableView].forEach{
            view.addSubview($0)
        }
        
        headerView.addSubview(titleLabel)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        titleLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    private func bind() {
        
        viewModel.gameListRelay
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: SelectGameCell.identifier, cellType: SelectGameCell.self)) { (row, cellModel, cell) in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(SelectGameCellModel.self)
            .bind(to: viewModel.selectedGame)
            .disposed(by: disposeBag)
    }
}
