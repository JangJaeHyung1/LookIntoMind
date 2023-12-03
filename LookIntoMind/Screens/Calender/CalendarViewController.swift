//
//  CalenderViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import FSCalendar

class CalendarViewController: UIViewController {
    private let leftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow_left"), for: .normal)
        btn.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let rightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow_right"), for: .normal)
        btn.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let calendarView: FSCalendar = {
        let view = FSCalendar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var currentPage: Date?
    let calendarCurrent = Calendar.current
    let today: Date = Date()
    var dateComponents = DateComponents()
    var records: [DataModel] = [] {
        didSet {
            
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.records.count != LoadData.items.count {
            self.records = LoadData.items
            calendarView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
extension CalendarViewController {
    private func setUp() {
        configure()
        setCalendar()
        addViews()
        setConstraints()
        bind()
        setCalendar()
    }
    
    private func configure() {
        view.backgroundColor = BaseColor.gray7
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    private func bind() {
        leftBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.moveCurrentPage(moveUp: false)
            })
            .disposed(by: disposeBag)
        
        rightBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.moveCurrentPage(moveUp: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func addViews() {
        view.addSubview(calendarView)
        view.addSubview(rightBtn)
        view.addSubview(leftBtn)
    }
    
    private func setConstraints() {
        calendarView.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(380)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        leftBtn.snp.makeConstraints { make in
            make.width.height.equalTo(14 + 20)
            make.centerX.equalTo(calendarView.calendarHeaderView).offset(-52)
            make.centerY.equalTo(calendarView.calendarHeaderView).offset(4)
        }
        rightBtn.snp.makeConstraints { make in
            make.width.height.equalTo(leftBtn)
            make.centerX.equalTo(calendarView.calendarHeaderView).offset(52)
            make.centerY.equalTo(leftBtn)
        }
        
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDelegateFlowLayout {
    
    private func moveCurrentPage(moveUp: Bool) {
        
        
        dateComponents.month = moveUp ? 1 : -1
        currentPage = calendarCurrent.date(byAdding: dateComponents, to: currentPage ?? today)
        self.calendarView.setCurrentPage(currentPage!, animated: true)
        
    }
    
    private func setCalendar() {
        calendarView.register(CalendarCollectionViewCell.self, forCellReuseIdentifier: CalendarCollectionViewCell.cellId)
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.headerHeight = 66
        
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        calendarView.appearance.headerDateFormat = "YYYY.MM"
        calendarView.appearance.headerTitleColor = BaseColor.black
        calendarView.appearance.headerTitleFont = BaseFont.title2_num
        
        calendarView.appearance.titleSelectionColor = BaseColor.gray4
        calendarView.appearance.todayColor = UIColor.clear
        calendarView.appearance.selectionColor = UIColor.clear
        
        calendarView.appearance.weekdayFont = BaseFont.body2
        calendarView.appearance.weekdayTextColor = BaseColor.gray3
        
        calendarView.appearance.titleSelectionColor = UIColor.clear
        calendarView.appearance.titleDefaultColor = UIColor.clear
        calendarView.appearance.titleWeekendColor = UIColor.clear
        calendarView.appearance.titleTodayColor = UIColor.clear
        calendarView.appearance.titleFont = BaseFont.body2_num
        
        calendarView.placeholderType = .none
        calendarView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        guard let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCollectionViewCell.cellId, for: date, at: position) as? CalendarCollectionViewCell else { return FSCalendarCell() }
        
        cell.configure(with: records, date: date)
        return cell
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // 캘린더를 스와이프해서 이전/다음 달로 넘길 때,
        // 타이틀뷰에 있는 레이블 값을 바꿔준다 (October)
//        calendarView.reloadData()
    }
    
    func presentRecordVC(mainCategory: MainCategory, subCategory: String, content: String, recordDate: Date, backEnable: Bool) {
        let nextVC = RecordsViewController(mainCategory: mainCategory, subCategory: subCategory, content: content, recordDate: recordDate, backEnable: backEnable)
        if backEnable {
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        guard let selectedData = records.filter({$0.date.summary == date.summary}).first else {
            return
        }
        presentRecordVC(mainCategory: selectedData.category, subCategory: selectedData.subCategory, content: selectedData.content, recordDate: date, backEnable: false)
    }
}
