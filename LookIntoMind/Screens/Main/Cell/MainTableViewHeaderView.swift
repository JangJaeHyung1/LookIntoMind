//
//  MainHeaderView.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/09.
//

import UIKit
import SnapKit

class MainHeaderView: UIView {
    
    let headerTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = BaseFont.title2
        lbl.textColor = BaseColor.gray1
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "오늘"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = BaseColor.gray7
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(headerTitleLbl)
        
        setConstraints()
    }
    
    private func setConstraints() {
        headerTitleLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
