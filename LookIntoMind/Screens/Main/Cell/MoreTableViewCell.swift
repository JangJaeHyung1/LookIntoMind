//
//  MoreTableViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/11.
//

import UIKit
import RxSwift
import RxCocoa

class MoreTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "MoreTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let moreBtnBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 24
        view.backgroundColor = BaseColor.gray6
        return view
    }()
    
    private let btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.isHidden = true
        return btn
    }()
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.body4_num
        lbl.textColor = BaseColor.gray2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "감정 더보기"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let downArrowImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrow_down")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = BaseColor.gray7
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(moreBtnBGView)
        moreBtnBGView.addSubview(title)
        moreBtnBGView.addSubview(downArrowImageView)
        moreBtnBGView.addSubview(btn)
        
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moreBtnBGView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(48)
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
        }
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.centerY.equalToSuperview()
        }
        downArrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.leading.equalTo(title.snp.trailing).offset(7)
            make.centerY.equalTo(title)
            
        }
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
