//
//  RealmDataModel.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/26.
//

import Foundation
import RealmSwift

class RealmDataModel: Object {
    @Persisted(indexed: true) var date: Date // primary key로 지정
    @Persisted var category: MainCategory.RawValue
    @Persisted var subCategory: String
    @Persisted var content: String
    convenience init(date: Date, category: MainCategory.RawValue, subCategory: String, content: String) {
        self.init()
        self.date = date
        self.category = category
        self.subCategory = subCategory
        self.content = content
    }
}

class RealmLoadDataModel: Object {
    @Persisted(indexed: true) var date: Date // primary key로 지정
    @Persisted var category: MainCategory.RawValue
    @Persisted var subCategory: String?
    @Persisted var content: String?
    convenience init(date: Date, category: MainCategory.RawValue, subCategory: String?, content: String?) {
        self.init()
        self.date = date
        self.category = category
        self.subCategory = subCategory
        self.content = content
    }
}
