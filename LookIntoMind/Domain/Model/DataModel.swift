//
//  DataModel.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/06.
//

import Foundation

struct DataModel {
    var date: Date
    var category: MainCategory
    var content: String
}

enum MainCategory: String {
    case wonder = "경이"
    case pleasure = "기쁨"
    case sympathy = "동정"
    
    case interest = "흥미"
    case affection = "애정"
    case worry = "걱정"
    
    case fear = "공포"
    case anger = "노여움"
    case embarrassment = "당황"
    
    case sorry = "미안함"
    case hate = "미움"
    case discomfort = "불편함"
    
    case shame = "부끄러움"
    case sadness = "슬픔"
    case regret = "아쉬움"
    
    case disgust = "싫음"
    case wind = "바람"
    case boredom = "지루함"
    
}
