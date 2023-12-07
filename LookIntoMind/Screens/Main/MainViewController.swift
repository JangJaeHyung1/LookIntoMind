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
import RealmSwift


class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = MainViewModel()
    var tableView: UITableView!
   
    private let safeBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray7
        return view
    }()
    
    private let loadDummyDataBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("테스트 데이터 가져오기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.isHidden = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.fetchTempLoadAndTodayData.onNext(())
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
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func configure() {
        view.backgroundColor = BaseColor.gray7
    }
    
    private func fetch() {
        viewModel.input.firstFetch.onNext(())
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
        tableView.backgroundColor = BaseColor.gray7
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func bind() {
        viewModel.output.loadDummyDataBtnIsHidden
            .bind(to: loadDummyDataBtn.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.spinnerStart
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                tableView.tableFooterView = createSpinnerView()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.tableViewReloadData
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.tableView.tableFooterView = nil
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.loadDummyDataBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.loadDummyDataBtn.isHidden = true
                self.viewModel.loadDummyData()
            })
            .disposed(by: disposeBag)
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(loadDummyDataBtn)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        loadDummyDataBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-200)
            make.centerX.equalToSuperview()
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
            if viewModel.output.recordData.value.isEmpty {
                return 1
            } else {
                if !viewModel.output.moreBtnIsHidden.value {
                    return viewModel.output.recordData.value.count + 1
                } else {
                    return viewModel.output.recordData.value.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - 테이블뷰 셀
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
            cell.configure(with: self.viewModel.output.todayData.value, idx: indexPath)
            return cell
        } else {
            if viewModel.output.recordData.value.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.cellId, for: indexPath) as! EmptyTableViewCell
                return cell
            } else {
                // 더보기 버튼 눌렀을 때
                if !viewModel.output.moreBtnIsHidden.value && indexPath == tableView.lastIndexpath() {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewCell.cellId, for: indexPath) as! MoreTableViewCell
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
                    cell.configure(with: viewModel.output.recordData.value[indexPath.row], idx: indexPath)
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
        if viewModel.output.moreBtnIsHidden.value && indexPath.section == 1 {
            if indexPath == tableView.lastIndexpath() {
                viewModel.input.fetchNextPageData.onNext(())
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if viewModel.output.todayData.value == nil {
                // 일기쓰기
                if viewModel.output.tempLoadData.value != nil {
                    presentModal()
                } else {
                    presentCreateVC(loadData: nil, todayDate: self.viewModel.output.todayDate)
                }
            } else {
                // 일기보기
                guard let todayData = viewModel.output.todayData.value else { return }
                presentRecordVC(mainCategory: todayData.category, subCategory: todayData.subCategory, content: todayData.content, recordDate: todayData.date, backEnable: true)
            }
        } else {
            if !viewModel.output.recordData.value.isEmpty {
                if tableView.lastIndexpath() == indexPath && !viewModel.output.moreBtnIsHidden.value {
                    viewModel.input.tapMoreBtn.onNext(())
                } else {
                    // 일기보기
                    let data = viewModel.output.recordData.value[indexPath.row]
                    presentRecordVC(mainCategory: data.category, subCategory: data.subCategory, content: data.content, recordDate: data.date, backEnable: true)
                }
            }
        }
    }
    
    private func presentModal() {
        let sheet = UIAlertController(title: "작성 중인 일기가 있어요", message: "이어서 작성하시겠어요?", preferredStyle: .alert)

        let leftAlert = UIAlertAction(title: "새로 쓰기", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.output.tempLoadData.accept(nil)
            Task {
                try RealmAPI.shared.deleteTemp()
                self.presentCreateVC(loadData: nil, todayDate: self.viewModel.output.todayDate)
            }
        })
        let rightAlert = UIAlertAction(title: "이어서 쓰기", style: .default, handler: { _ in
            self.presentCreateVC(loadData: self.viewModel.output.tempLoadData.value, todayDate: self.viewModel.output.todayDate)
        })
        
        leftAlert.setValue(BaseColor.gray3, forKey: "titleTextColor")
        rightAlert.setValue(BaseColor.black, forKey: "titleTextColor")
        sheet.addAction(leftAlert)
        sheet.addAction(rightAlert)

        present(sheet, animated: true)
    }
}

// MARK: - naviagtion

extension MainViewController {
    func presentRecordVC(mainCategory: MainCategory, subCategory: String, content: String, recordDate: Date, backEnable: Bool) {
        let nextVC = RecordsViewController(mainCategory: mainCategory, subCategory: subCategory, content: content, recordDate: recordDate, backEnable: backEnable)
        if backEnable {
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
    func presentCreateVC(loadData: DataModel?, todayDate: Date) {
        let nextVC = FirstCreateViewController(loadData: loadData, todayDate: self.viewModel.output.todayDate)
        removeTempSaveData()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func removeTempSaveData() {
        SaveData.date = nil
        SaveData.category = nil
        SaveData.subCategory = nil
        SaveData.content = nil
    }
    
}
