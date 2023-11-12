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
    var subCategory: String
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

struct SubCategory {
    static let array: [MainCategory: [String]] =
    [.wonder: ["경이롭다", "기막히다", "놀랍다", "신기하다", "신비롭다"],
     .pleasure: ["감격스럽다", "기쁘다","뭉클하다", "벅차다", "뿌듯하다", "통쾌하다"],
     .sympathy: ["가엾다", "불쌍하다", "안쓰럽다"],

     .interest: ["고소하다", "담담하다", "만족스럽다", "좋다", "편안하다", "행복하다", "홀가분하다", "흐뭇하다"],
     .affection: ["감사하다", "고맙다", "기특하다", "대견하다", "든든하다", "반갑다", "사랑스럽다", "애틋하다", "자랑스럽다"],
     .worry: ["걱정스럽다", "고민스럽다", "불안하다", "초조하다"],

     .fear: ["두렵다", "무섭다", "무시무시하다"],
     .anger: ["분하다", "어이없다", "억울하다", "언짢다", "역겹다", "원망스럽다", "짜증스럽다"],
     .embarrassment: ["곤혹스럽다", "당황스럽다", "어리둥절하다", "의아하다", "혼란스럽다", "황당하다"],

     .sorry: ["미안하다", "죄송하다"],
     .hate: ["괘씸하다", "밉다", "야속하다", "얄밉다"],
     .discomfort: ["무안하다", "민망하다", "부끄럽다", "수줍다", "쑥스럽다", "창피하다"],

     .shame: ["갑갑하다", "거북하다", "고통스럽다", "괴롭다", "귀찮다", "답답하다", "부담스럽다", "서먹하다", "먹먹하다"],
     .sadness: ["비참하다", "서글프다", "서럽다", "서운하다", "섭섭하다", "속상하다", "슬프다", "쓸쓸하다", "애석하다", "외롭다", "우울하다", "처량하다", "처절하다", "처참하다", "허무하다", "허전하다", "허탈하다"],
     .regret: ["시원섭섭하다", "실망스럽다", "아깝다", "아쉽다", "안타깝다", "후회스럽다"],

     .disgust: ["끔찍하다", "꺼림칙하다", "불만족스럽다", "불만스럽다", "싫다", "씁쓸하다", "한심하다"],
     .wind: ["간절하다", "궁금하다", "그립다", "부럽다"],
     .boredom: ["무료하다", "심심하다", "재미없다", "지겹다", "지루하다"]
    ]
}
