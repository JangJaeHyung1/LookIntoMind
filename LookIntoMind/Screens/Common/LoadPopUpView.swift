//
//  LoadPopUpView.swift
//  LookIntoMind
//
//  Created by jh on 2023/12/10.
//

import UIKit
import SnapKit

class LoadPopUpView: UIView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        view.layer.opacity = 0.63
        return view
    }()
    
    private let modalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = BaseFont.title2
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "작성 중인 일기가 있어요"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = BaseFont.body4
        lbl.textColor = BaseColor.gray3
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "이어서 작성하시겠어요?"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let leftLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.black
        lbl.font = BaseFont.body2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "새로 쓰기"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let leftBtn: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let rightLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray3
        lbl.font = BaseFont.body2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "이어서 쓰기"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    let rightBtn: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let line1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray5
        return view
    }()
    
    private let line2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(backgroundView)
        addSubview(modalView)
        modalView.addSubview(titleLbl)
        modalView.addSubview(subTitleLbl)
        modalView.addSubview(leftLbl)
        modalView.addSubview(rightLbl)
        modalView.addSubview(line1)
        modalView.addSubview(line2)
        modalView.addSubview(leftBtn)
        modalView.addSubview(rightBtn)
        
        setConstraints()
    }
    
    private func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        modalView.snp.makeConstraints { make in
            make.width.equalTo(294)
            make.height.equalTo(112 + 56)
            make.center.equalToSuperview()
        }
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(24)
        }
        
        subTitleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(4)
            make.height.equalTo(20)
        }
        
        line1.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(subTitleLbl.snp.bottom).offset(32)
            make.height.equalTo(1)
        }
        
        line2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.top.equalTo(line1)
            make.bottom.equalToSuperview()
        }
        
        leftLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-294/4)
            make.centerY.equalTo(line2)
        }
        
        rightLbl.snp.makeConstraints { make in
            make.centerY.equalTo(leftLbl)
            make.centerX.equalToSuperview().offset(294/4)
        }
        
        leftBtn.snp.makeConstraints { make in
            make.center.equalTo(leftLbl)
            make.height.equalTo(leftLbl).offset(30)
            make.width.equalTo(leftLbl).offset(30)
        }
        
        rightBtn.snp.makeConstraints { make in
            make.center.equalTo(rightLbl)
            make.height.equalTo(rightLbl).offset(30)
            make.width.equalTo(rightLbl).offset(30)
        }
    }

}
