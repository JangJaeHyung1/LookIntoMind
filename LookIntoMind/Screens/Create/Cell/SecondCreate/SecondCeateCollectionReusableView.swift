//
//  SecondCeateCollectionReusableView.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/19.
//

import UIKit
import SnapKit

class SecondCeateCollectionReusableView: UICollectionReusableView {
    static let cellID = "SecondCeateCollectionReusableView"
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.title1
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "천천히 곱씹은 마음을\n골라주세요"
        lbl.isUserInteractionEnabled = true
        //    lbl.adjustsFontSizeToFitWidth = true
        //    lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    private let selectedMainCategoryBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 16
        view.backgroundColor = BaseColor.gray6
        return view
    }()
    
    private let selectedMainCategoryGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray3
        lbl.font = BaseFont.body4
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "지금 떠오른 내 마음은"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let selectedMainCategoryLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.black
        lbl.font = BaseFont.body1
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let selectedMainCategoryImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.gray7
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(title)
        addSubview(selectedMainCategoryBGView)
        selectedMainCategoryBGView.addSubview(selectedMainCategoryGuideLbl)
        selectedMainCategoryBGView.addSubview(selectedMainCategoryLbl)
        selectedMainCategoryBGView.addSubview(selectedMainCategoryImage)
        
        setConstraints()
    }
    
    private func setConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        selectedMainCategoryBGView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
            make.top.equalTo(title.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(-28)
        }
        
        selectedMainCategoryGuideLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(21)
        }
        
        selectedMainCategoryLbl.snp.makeConstraints { make in
            make.leading.trailing.equalTo(selectedMainCategoryGuideLbl)
            make.top.equalTo(selectedMainCategoryGuideLbl.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-21)
        }
        
        selectedMainCategoryImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with category: String) {
        selectedMainCategoryLbl.text = category
        selectedMainCategoryImage.image = UIImage(named: category)
    }
}
