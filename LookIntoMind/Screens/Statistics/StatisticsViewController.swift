//
//  StatisticsViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StatisticsViewController: UIViewController {
    // MARK: - ui
    var tableView: UITableView!
    
    private let emptyGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = BaseFont.title2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "기록한 마음이 없어요."
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let emptyGuideLbl2: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = BaseColor.gray3
        lbl.font = BaseFont.body4
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "일기를 작성하고 마음을 모아보세요 "
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    
    // MARK: - var
    var monthKeys: [String] = []
    
    
    
    // MARK: - init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension StatisticsViewController {
    private func setUp() {
        configure()
        setNavi()
        setTableView()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    
    private func setTableView(){
        tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 44, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.cellId)
        tableView.backgroundColor = BaseColor.gray7
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func configure() {
        view.backgroundColor = BaseColor.gray7
        for month in MonthRecords.dict.keys.sorted().reversed() {
            monthKeys.append(month)
        }
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        view.addSubview(emptyGuideLbl)
        view.addSubview(emptyGuideLbl2)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        emptyGuideLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emptyGuideLbl2.snp.top).offset(-8)
        }
        emptyGuideLbl2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).offset(4)
        }
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview()
        }
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MonthRecords.dict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.cellId, for: indexPath) as! StatisticsTableViewCell
        cell.selectionStyle = .none
        let month = monthKeys[indexPath.row]
        if let data = MonthRecords.dict[month] {
            let sortedDictionary = data.sorted { $0.1 > $1.1 }.filter({ $0.1 != 0 })
            cell.configure(with: sortedDictionary, date: month)
            cell.nextBtn.rx.tap
                .subscribe(onNext:{ [weak self] res in
                    guard let self else { return }
                    self.presentNextVC(sortedDictionary: sortedDictionary, date: month)
                })
                .disposed(by: cell.disposeBag)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func presentNextVC(sortedDictionary: [Dictionary<MainCategory, Int>.Element], date: String) {
        let nextVC = StatsticsDetailViewController(sortedDictionary: sortedDictionary, date: date)
        self.navigationController?.pushViewController(nextVC, animated: false)
        
    }
}
