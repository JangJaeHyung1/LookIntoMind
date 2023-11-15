//
//  MainViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Realm


class MainViewController: UIViewController {

    var tableView: UITableView!
    var moreBtnIsHidden: Bool = false
    var todayData: DataModel?
    var recordData: [DataModel] = [
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.worry]![0], content: "흠..1"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.wonder]![0], content: "흠..2"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.anger]![0], content: "흠..3"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.anger]![0], content: "흠..4"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.anger]![0], content: "흠..5"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.anger]![0], content: "흠..6"),
        DataModel(date: Date(), category: .anger, subCategory: SubCategory.array[.anger]![0], content: "흠..7"),
    ]
    private let safeBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray7
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension MainViewController {
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
        view.backgroundColor = BaseColor.gray7
    }
    
    private func fetch() {
        
    }
    
    private func setTableView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: MoreTableViewCell.cellId)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.cellId)
//        tableView.contentInset.bottom = 40
        tableView.backgroundColor = BaseColor.gray7
        //    private let refreshControl = UIRefreshControl()
        //    tableView.refreshControl = refreshControl
        //    refreshControl.transform = .init(scaleX: 0.75, y: 0.75)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func bind() {
        
    }
    
    private func setNavi() {
        //        self.navigationItem.title = "<#title#>"
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        //        self.navigationItem.largeTitleDisplayMode = .always
        //        self.navigationItem.setHidesBackButton(true, animated: true)
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if recordData.isEmpty {
                return 1
            } else {
                if !moreBtnIsHidden {
                    return recordData.count + 1
                } else {
                    return recordData.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - 테이블뷰 셀
        tableView.tableFooterView = nil
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
            cell.configure(with: self.todayData, idx: indexPath)
            return cell
        } else {
            if recordData.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.cellId, for: indexPath) as! EmptyTableViewCell
                return cell
            } else {
                if !moreBtnIsHidden {
                    if indexPath == tableView.lastIndexpath() {
                        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.cellId, for: indexPath) as! MoreTableViewCell
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
                        cell.configure(with: recordData[indexPath.row], idx: indexPath)
                        return cell
                    }
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
                    cell.configure(with: recordData[indexPath.row], idx: indexPath)
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
     
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let headerView = MainHeaderView()
            headerView.headerTitleLbl.text = "지난 마음"
            return headerView
        } else {
            return MainHeaderView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if moreBtnIsHidden && indexPath.section == 1{
            if indexPath == tableView.lastIndexpath() {
                // fetch
                tableView.tableFooterView = createSpinnerView()
                recordData += recordData
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if todayData == nil {
                // 일기쓰기
            } else {
                // 일기보기
            }
        } else {
            if !recordData.isEmpty {
                if tableView.lastIndexpath() == indexPath && !moreBtnIsHidden{
                    print("tap 감정더보기")
                    moreBtnIsHidden = true
                    // fetch
                    tableView.tableFooterView = createSpinnerView()
                    recordData += recordData
                    tableView.reloadData()
                } else {
                    // 일기보기
                }
            }
        }
    }
    
}
