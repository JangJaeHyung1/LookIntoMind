//
//  NaviView.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/18.
//

import UIKit
import SnapKit

class NaviView: UIView {

    private let safeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray7
        return view
    }()
    let naviView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray7
        return view
    }()
    let progressBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray5
        return view
    }()
    let progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        
        return view
    }()
    
    let backBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "arrow_back")
        btn.setImage(img, for: .normal)
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "dismiss")
        btn.setImage(img, for: .normal)
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    
    init(backBtnEnable: Bool = true) {
        if backBtnEnable {
            dismissBtn.isHidden = true
        } else {
            backBtn.isHidden = true
        }
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(safeView)
        addSubview(naviView)
        naviView.addSubview(backBtn)
        naviView.addSubview(dismissBtn)
        
        addSubview(progressBGView)
        progressBGView.addSubview(progressView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        safeView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        naviView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeView.snp.bottom)
            make.height.equalTo(44)
        }
        
        backBtn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(34)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        dismissBtn.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerY.equalTo(backBtn)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        progressBGView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(naviView.snp.bottom)
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}
