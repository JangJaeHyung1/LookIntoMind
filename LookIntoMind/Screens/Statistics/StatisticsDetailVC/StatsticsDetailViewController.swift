//
//  StatsticsDetailViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/12/09.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StatsticsDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var sortedDictionary: [Dictionary<MainCategory, Int>.Element]
    var tableView: UITableView!
    var date: String
    
    private let naviView: NaviView = {
        let view = NaviView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = BaseFont.title2_num
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    init(sortedDictionary: [Dictionary<MainCategory, Int>.Element], date: String) {
        self.sortedDictionary = sortedDictionary
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

    }
}



extension StatsticsDetailViewController {
    private func setUp() {
        configure()
        setTableView()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func configure() {
        view.backgroundColor = .white
        dateLbl.text = date
    }
    
    private func setTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StatisticsCommonTableViewCell.self, forCellReuseIdentifier: StatisticsCommonTableViewCell.cellId)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.progressBGView.isHidden = true
        naviView.progressView.isHidden = true
        naviView.safeView.backgroundColor = .white
        naviView.naviView.backgroundColor = .white
    }
    
    private func addViews() {
        view.addSubview(naviView)
        naviView.addSubview(dateLbl)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        dateLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(naviView.backBtn)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(naviView.snp.bottom).offset(40 - 16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension StatsticsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCommonTableViewCell.cellId, for: indexPath) as! StatisticsCommonTableViewCell
        cell.selectionStyle = .none
        let category: String = "\(sortedDictionary[indexPath.row].key.rawValue)"
        let percent: Int = sortedDictionary[indexPath.row].value
        cell.configure(with: category, percent: percent, max: sortedDictionary[0].value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
