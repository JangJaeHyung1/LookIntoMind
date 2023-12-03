//
//  TabbarPage.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/24.
//

import Foundation

enum TabBarPage: String, CaseIterable {
    case calandar, main, statistics
    
    init?(index: Int) {
        switch index {
        case 0: self = .calandar
        case 1: self = .main
        case 2: self = .statistics
        default: return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .calandar: return 0
        case .main: return 1
        case .statistics: return 2
        }
    }
    
    func tabIconName() -> String {
        return self.rawValue
    }
}
