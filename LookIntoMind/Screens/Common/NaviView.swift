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
    private let progressBGView: UIView = {
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
    private let backImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrow_back")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(safeView)
        addSubview(naviView)
        naviView.addSubview(backImage)
        naviView.addSubview(backBtn)
        
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
        
        backImage.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(backImage).offset(20)
            make.center.equalTo(backImage)
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
