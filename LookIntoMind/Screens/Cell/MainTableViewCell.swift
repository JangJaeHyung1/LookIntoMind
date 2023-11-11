//
//  MainTableViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class MainTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "MainTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.body4_num
        lbl.textColor = BaseColor.gray3
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "11.5 일요일"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = BaseFont.body1
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "마음 들여다보기"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let emotionImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "wonder")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = BaseColor.gray7
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
        cellView.addSubview(dateLbl)
        cellView.addSubview(titleLbl)
        cellView.addSubview(emotionImageView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        dateLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(21.5)
        }
        titleLbl.snp.makeConstraints { make in
            make.leading.equalTo(dateLbl)
            make.top.equalTo(dateLbl.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-22.5)
        }
        emotionImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
    func configure(with presentable: DataModel, idx: IndexPath) {
        if idx.section == 0 {
            titleLbl.text = "마음 들여다보기"
            cellView.backgroundColor = BaseColor.black
            titleLbl.textColor = BaseColor.white
            emotionImageView.image = UIImage(named: "today_next")
            
        } else {
//            titleLbl.text =
            titleLbl.text = presentable.subCategory
            cellView.backgroundColor = BaseColor.white
            titleLbl.textColor = BaseColor.black
            emotionImageView.image = UIImage(named: presentable.category.rawValue)
        }
    }
}
