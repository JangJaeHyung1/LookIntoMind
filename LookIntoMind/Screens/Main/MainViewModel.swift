//
//  MainVM.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/09.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let tapMoreBtn = PublishSubject<Void>()
        let fetchNextPageData = PublishSubject<Void>()
        let firstFetch = PublishSubject<Void>()
        let fetchTempLoadAndTodayData = PublishSubject<Void>()
    }
    struct Output {
        // ui
        let moreBtnIsHidden = BehaviorRelay<Bool>(value: false)
        let loadDummyDataBtnIsHidden = BehaviorRelay<Bool>(value: false)
        let tableViewReloadData = PublishSubject<Void>()
        let spinnerStart = PublishSubject<Void>()
        
        // data
        let tempLoadData = BehaviorRelay<DataModel?>(value: nil) // 임시저장한 불러온 데이터
        let fetchData = BehaviorRelay<[DataModel]>(value: []) // 오늘을 제외한 모든 데이터
        let recordData = BehaviorRelay<[DataModel]>(value: []) // fetchData에서 페이징하여 보여지고 있는 데이터
        let todayData = BehaviorRelay<DataModel?>(value: nil)
        let pageNum = BehaviorRelay<Int>(value: 1)
        let todayDate = Date()
        
    }
    
    init() {
        transform()
    }
    private func transform(){
        
        input.fetchNextPageData
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                if self.output.recordData.value.count > 0 {
                    self.fetchPage()
                }
            })
            .disposed(by: disposeBag)
        
        input.tapMoreBtn.asObserver()
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                output.moreBtnIsHidden.accept(true)
                input.fetchNextPageData.onNext(())
            })
            .disposed(by: disposeBag)
        
        input.firstFetch.asObserver()
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.fetchData()
            })
            .disposed(by: disposeBag)
        
        input.fetchTempLoadAndTodayData.asObserver()
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.fetchTemp()
                self.fetchToday()
            })
            .disposed(by: disposeBag)
        
    }
    
    
    func loadDummyData() {
        let dummyData = Dummy.data
        Task{
            for data in dummyData {
                _ = try RealmAPI.shared.save(item: data)
            }
            RealmAPI.shared.saveMonthRecordData(items: dummyData)
            fetchData()
        }
    }
    private func fetchData() {
        // 1. 데이터가 12개 미만이면 more Btn 비활성화
        // 2. 데이터가 12개 이상이면 more Btn 활성화
        // 3. 데이터가 12개 이상일때 more btn 이후 12개씩 불러오기
        // 4. 데이터가 더 불러올게 없으면 Fetch 하지않음
        // 5. 오늘 날짜 데이터는 삭제
        // 6. 테스트 더미 불러오기 버튼 히든
        do {
            var data = try RealmAPI.shared.load()
            output.loadDummyDataBtnIsHidden.accept(data.count > 3)
            LoadData.items = data
            for (index, datum) in data.enumerated() {
                if datum.date.summary == output.todayDate.summary {
                    data.remove(at: index)
                }
            }
            output.fetchData.accept(data)
            output.moreBtnIsHidden.accept(data.count < 12)
            output.pageNum.accept(1)
            fetchPage()
        } catch {
            print("❌ mainVM fetchData() load error: \(error.localizedDescription)")
        }
    }
    
    private func fetchPage() {
        let fetchData = output.fetchData.value
        let pageNum = output.pageNum.value
        if output.pageNum.value != -1 {
            output.spinnerStart.onNext(())
            let endIndex = 12 * pageNum
            let safeEndIndex = min(endIndex, fetchData.count)
            let resultArray = Array(fetchData[0..<safeEndIndex])
            output.pageNum.accept(pageNum + 1)
            if fetchData.count == output.recordData.value.count {
                output.pageNum.accept(-1)
            } else {
                output.recordData.accept(resultArray)
            }
            output.tableViewReloadData.onNext(())
        }
    }
    
    private func fetchToday() {
        do {
            let todayData = try RealmAPI.shared.loadToday()
            output.todayData.accept(todayData)
            output.tableViewReloadData.onNext(())
        } catch {
            print("❌ fetch loadToday error: \(error.localizedDescription)")
        }
    }
    
    private func fetchTemp() {
        Task{
            if let tempData = try RealmAPI.shared.tempLoad() {
                output.tempLoadData.accept(DataModel(date: tempData.date, category: tempData.category, subCategory: tempData.subCategory ?? "", content: tempData.content ?? ""))
            } else {
                output.tempLoadData.accept(nil)
            }
        }
    }
}


