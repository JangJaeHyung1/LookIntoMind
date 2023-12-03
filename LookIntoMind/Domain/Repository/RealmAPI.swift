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
            print("❌ Realm API deleteTemp error: \(error.localizedDescription)")
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
            print("❌ Realm API temp save error: \(error.localizedDescription)")
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
//            debugPrint("🔵 Realm API tempLoad success")
            debugPrint("🔵 Realm API tempLoad success : \(data)")
            return data
        } catch {
            print("❌ Realm API tempLoad error: \(error.localizedDescription)")
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
            print("❌ Realm API save error: \(error.localizedDescription)")
            return false
        }
        return true
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
            print("❌ Realm API load error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func loadToday() throws -> DataModel {
        do {
            let items = try RealmAPI.shared.load()
            LoadData.items = items
            if let item = items.filter({ $0.date.toString($0.date.summary) == Date().toString(Date().summary)}).first {
                let todayData = DataModel(date: item.date, category: item.category, subCategory: item.subCategory, content: item.content)
                debugPrint("🔵 Realm API loadToday success")
//                debugPrint("🔵 Realm API loadToday success : \(todayData)")
                return todayData
            } else {
                throw ErrorType.RealmTodayDataNil
            }
        } catch {
            print("❌ Realm API loadToday error: \(error.localizedDescription)")
            throw error
        }
    }
    
}
