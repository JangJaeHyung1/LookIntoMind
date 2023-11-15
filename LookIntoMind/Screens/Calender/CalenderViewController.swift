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

class CalenderViewController: UIViewController {

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
    var records: [DataModel] = [
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 01))!, category: .affection, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기1"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 02))!, category: .worry, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기2"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 04))!, category: .anger, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기3"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 06))!, category: .discomfort, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기4"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 07))!, category: .boredom, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기5"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 10))!, category: .fear, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기6"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 14))!, category: .embarrassment, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기7"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 15))!, category: .pleasure, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기8"),
        .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 16))!, category: .pleasure, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기9"),
    ]
    
    private let disposeBag = DisposeBag()
    
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
extension CalenderViewController {
    private func setUp() {
        configure()
        setCalendar()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setCalendar()
    }
    
    private func configure() {
        view.backgroundColor = BaseColor.gray7
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    private func fetch() {
        
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

extension CalenderViewController: FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDelegateFlowLayout {
    
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
        calendarView.appearance.selectionColor = UIColor.clear
        calendarView.appearance.titleSelectionColor = BaseColor.gray4
        
        calendarView.appearance.todayColor = UIColor.clear
        // 월 ~ 일
        calendarView.appearance.weekdayFont = BaseFont.body2
        calendarView.appearance.weekdayTextColor = BaseColor.gray3
        // 평일 & 주말 색상 설정
        calendarView.appearance.titleDefaultColor = BaseColor.gray4  // 평일
        calendarView.appearance.titleWeekendColor = BaseColor.gray4  // 주말
        calendarView.appearance.titleFont = BaseFont.body2_num
        let todayRecord = records.filter({$0.date.toString($0.date.summary) == Date().toString(Date().summary)}).first
        if todayRecord == nil {
            calendarView.appearance.titleTodayColor = BaseColor.black
        } else {
            calendarView.appearance.titleTodayColor = BaseColor.white
        }
        // 달에 유효하지 않은 날짜 없애기
        calendarView.placeholderType = .none
     
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        guard let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCollectionViewCell.cellId, for: date, at: position) as? CalendarCollectionViewCell else { return FSCalendarCell() }
        
        cell.configure(with: records, date: date)
        return cell
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // 캘린더를 스와이프해서 이전/다음 달로 넘길 때,
        // 타이틀뷰에 있는 레이블 값을 바꿔준다 (October)
        calendarView.reloadData()
    }
}
