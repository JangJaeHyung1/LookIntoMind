//
//  LoadData.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/28.
//

import Foundation

struct LoadData {
    static var items: [DataModel] = []
}

struct TodayLoadData {
    static var items: [DataModel] = []
}


struct Dummy {
    static var data: [DataModel] =
    [.init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 01))!, category: .affection, subCategory: SubCategory.array[.affection]![0], content: "오늘의 일기1"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 02))!, category: .worry, subCategory: SubCategory.array[.worry]![0], content: "오늘의 일기2"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 04))!, category: .anger, subCategory: SubCategory.array[.anger]![0], content: "오늘의 일기3"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 06))!, category: .discomfort, subCategory: SubCategory.array[.discomfort]![0], content: "오늘의 일기4"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 07))!, category: .boredom, subCategory: SubCategory.array[.boredom]![0], content: "오늘의 일기5"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 10))!, category: .fear, subCategory: SubCategory.array[.fear]![0], content: "오늘의 일기6"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 14))!, category: .embarrassment, subCategory: SubCategory.array[.embarrassment]![0], content: "오늘의 일기7"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 15))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "오늘의 일기8"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 16))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "오늘의 일기9"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 01))!, category: .affection, subCategory: SubCategory.array[.affection]![0], content: "10월달 일기1"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 02))!, category: .worry, subCategory: SubCategory.array[.worry]![0], content: "10월달 일기2"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 04))!, category: .anger, subCategory: SubCategory.array[.anger]![0], content: "10월달 일기3"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 06))!, category: .discomfort, subCategory: SubCategory.array[.discomfort]![0], content: "10월달 일기4"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 07))!, category: .boredom, subCategory: SubCategory.array[.boredom]![0], content: "10월달 일기5"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 10))!, category: .fear, subCategory: SubCategory.array[.fear]![0], content: "10월달 일기6"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 14))!, category: .embarrassment, subCategory: SubCategory.array[.embarrassment]![0], content: "10월달 일기7"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 15))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "10월달 일기8"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 16))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "9월달 일기9"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 01))!, category: .affection, subCategory: SubCategory.array[.affection]![0], content: "9월달 일기1"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 02))!, category: .worry, subCategory: SubCategory.array[.worry]![0], content: "9월달 일기2"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 04))!, category: .anger, subCategory: SubCategory.array[.anger]![0], content: "9월달 일기3"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 06))!, category: .discomfort, subCategory: SubCategory.array[.discomfort]![0], content: "9월달 일기4"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 07))!, category: .boredom, subCategory: SubCategory.array[.boredom]![0], content: "9월달 일기5"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 10))!, category: .fear, subCategory: SubCategory.array[.fear]![0], content: "9월달 일기6"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 14))!, category: .embarrassment, subCategory: SubCategory.array[.embarrassment]![0], content: "9월달 일기7"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 15))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "9월달 일기8"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 16))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "9월달 일기9"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 01))!, category: .affection, subCategory: SubCategory.array[.affection]![0], content: "8월달 일기1"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 02))!, category: .worry, subCategory: SubCategory.array[.worry]![0], content: "8월달 일기2"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 04))!, category: .anger, subCategory: SubCategory.array[.anger]![0], content: "8월달 일기3"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 06))!, category: .discomfort, subCategory: SubCategory.array[.discomfort]![0], content: "8월달 일기4"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 07))!, category: .boredom, subCategory: SubCategory.array[.boredom]![0], content: "8월달 일기5"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 10))!, category: .fear, subCategory: SubCategory.array[.fear]![0], content: "8월달 일기6"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 14))!, category: .embarrassment, subCategory: SubCategory.array[.embarrassment]![0], content: "8월달 일기7"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 15))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "8월달 일기8"),
     .init(date: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 16))!, category: .pleasure, subCategory: SubCategory.array[.pleasure]![0], content: "8월달 일기9"),
    ]
}
