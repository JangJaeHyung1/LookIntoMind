//
//  StatisticsViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StatisticsViewController: UIViewController {
    // MARK: - ui
    var containerTableView: UITableView!
    var innerTableView: UITableView!
    
    // MARK: - var
    
    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}


extension StatisticsViewController {
    private func setUp() {
        configure()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func configure() {
        view.backgroundColor = BaseColor.gray7
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        
    }
    
    private func setConstraints() {
        
    }
}
