//
//  RealmAPI.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/28.
//

import Foundation
import RealmSwift

enum ErrorType: Error {
    case MainCategoryNil
    case RealmLoadDataNil
    case RealmTodayDataNil
}

class RealmAPI {
    static let shared = RealmAPI()
    private init() { }

    
    func deleteTemp() throws {
        do {
            let realm = try Realm()
            let oldData = realm.objects(RealmLoadDataModel.self)
            try realm.write {
                realm.delete(oldData)
                debugPrint("🔵 Realm API deleteTemp success")
            }
        } catch {
            debugPrint("❌ Realm API deleteTemp error: \(error.localizedDescription)")
        }
    }
    
    func tempSave(item: SaveDataModel) throws -> Bool {
        // 저장된 데이터 삭제
        // 메인 카테고리 선택했으면 오늘 날짜로 임시 데이터저장
        do {
            let realm = try Realm()
            let oldData = realm.objects(RealmLoadDataModel.self)
            try realm.write {
                realm.delete(oldData)
                let newData = RealmLoadDataModel(date: item.date, category: item.category.rawValue, subCategory: item.subCategory, content: item.content)
                realm.add(newData)
                debugPrint("🔵 Realm API tempSave success")
            }
        } catch {
            debugPrint("❌ Realm API temp save error: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func tempLoad() throws -> SaveDataModel? {
        do {
            let realm = try Realm()
            guard let item = realm.objects(RealmLoadDataModel.self).first else {
                return nil }
            guard let category = MainCategory(rawValue: item.category) else {
                return nil }
            let data = SaveDataModel(date: item.date, category: category, subCategory: item.subCategory, content: item.content)
            debugPrint("🔵 Realm API tempLoad success")
//            debugPrint("🔵 Realm API tempLoad success : \(data)")
            return data
        } catch {
            debugPrint("❌ Realm API tempLoad error: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    func save(item: DataModel) throws -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let newData = RealmDataModel(date: item.date, category: item.category.rawValue, subCategory: item.subCategory, content: item.content)
                realm.add(newData)
                debugPrint("🔵 Realm API save success")
            }
        } catch {
            debugPrint("❌ Realm API save error: \(error.localizedDescription)")
            return false
        }
        return true
    }

    func update(item: DataModel, matching originalDate: Date) throws -> Bool {
        do {
            let realm = try Realm()
            let startOfDay = Calendar.current.startOfDay(for: originalDate)
            guard let startOfNextDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else {
                return false
            }
            guard let savedData = realm.objects(RealmDataModel.self)
                .filter("date >= %@ AND date < %@", startOfDay, startOfNextDay)
                .first else {
                debugPrint("❌ Realm API update error: record not found for \(originalDate.summary)")
                return false
            }

            try realm.write {
                savedData.category = item.category.rawValue
                savedData.subCategory = item.subCategory
                savedData.content = item.content
                debugPrint("🔵 Realm API update success")
            }
        } catch {
            debugPrint("❌ Realm API update error: \(error.localizedDescription)")
            return false
        }
        return true
    }

    func delete(matching date: Date) throws -> Bool {
        do {
            let realm = try Realm()
            let startOfDay = Calendar.current.startOfDay(for: date)
            guard let startOfNextDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else {
                return false
            }
            guard let savedData = realm.objects(RealmDataModel.self)
                .filter("date >= %@ AND date < %@", startOfDay, startOfNextDay)
                .first else {
                debugPrint("❌ Realm API delete error: record not found for \(date.summary)")
                return false
            }

            try realm.write {
                realm.delete(savedData)
                debugPrint("🔵 Realm API delete success")
            }
        } catch {
            debugPrint("❌ Realm API delete error: \(error.localizedDescription)")
            return false
        }
        return true
    }

    func refreshCachedData() {
        do {
            let items = try load()
            LoadData.items = items
            saveMonthRecordData(items: items)
        } catch {
            debugPrint("❌ Realm API refreshCachedData error: \(error.localizedDescription)")
        }
    }
    
    func load() throws -> [DataModel] {
        do {
            let realm = try Realm()
            let items = realm.objects(RealmDataModel.self)
            var data: [DataModel] = []
            for item in items {
                data.append(DataModel(date: item.date, category: MainCategory(rawValue: item.category)!, subCategory: item.subCategory, content: item.content))
            }
            // date 기준 정렬
            data = data.sorted(by: { lhs, rhs in
                return lhs.date > rhs.date
            })
            debugPrint("🔵 Realm API load success")
//            debugPrint("🔵 Realm API load success : \(data)")
            return data
        } catch {
            debugPrint("❌ Realm API load error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func loadToday() throws -> DataModel {
        do {
            let items = try RealmAPI.shared.load()
            LoadData.items = items
            saveMonthRecordData(items: items)
            if let item = items.filter({ $0.date.toString($0.date.summary) == Date().toString(Date().summary)}).first {
                let todayData = DataModel(date: item.date, category: item.category, subCategory: item.subCategory, content: item.content)
                debugPrint("🔵 Realm API loadToday success")
//                debugPrint("🔵 Realm API loadToday success : \(todayData)")
                return todayData
            } else {
                throw ErrorType.RealmTodayDataNil
            }
        } catch {
            debugPrint("❌ Realm API loadToday error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func saveMonthRecordData(items: [DataModel]){
        MonthRecords.dict.removeAll()
        var categoryDict: [MainCategory: Int] = [:]
        var previousMonth = ""
        for item in items {
            let month = item.date.month
            if previousMonth != month {
                previousMonth = month
                categoryDict = [:]
            }
            if let monthDict = MonthRecords.dict[month] {
                // 해당 month의 데이터가 있을때
                if let count = monthDict[item.category] {
                    categoryDict.updateValue(count + 1, forKey: item.category)
                } else {
                    // 해당 category의 아이템이 없으면 category = 1
                    categoryDict.updateValue(1, forKey: item.category)
                }
            } else {
                // 해당 month의 데이터가 없을때 dictionary 객체 생성
                // 해당 category count = 1
                for category in MainCategory.allCases {
                    categoryDict.updateValue(category == item.category ? 1 : 0, forKey: category)
                }
            }
            MonthRecords.dict.updateValue(categoryDict, forKey: month)
        }
        
        // 최신순 정렬
        var monthKeys: [String] = []
        for month in MonthRecords.dict.keys.sorted().reversed() {
            monthKeys.append(month)
        }
        
        // 백분율로 변환
        for monthKey in monthKeys {
            guard let monthRecordDict = MonthRecords.dict[monthKey] else { return }
            let sum = (monthRecordDict.values).reduce(0, +)
            var newMonthCategoryDict: [MainCategory: Int] = monthRecordDict
            for categoryKey in monthRecordDict.keys {
                guard let categoryCount = monthRecordDict[categoryKey] else { return }
                let newValue = Int(ceil((Double(categoryCount)/Double(sum)) * 100))
                newMonthCategoryDict.updateValue(newValue, forKey: categoryKey)
            }
            MonthRecords.dict.updateValue(newMonthCategoryDict, forKey: monthKey)
        }
        
    }
    
}
