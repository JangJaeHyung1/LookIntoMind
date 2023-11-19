//
//  FirstCreateCVHeader.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/19.
//

import UIKit
import SnapKit

class FirstCreateCVHeader: UICollectionReusableView {
    static let cellID = "FirstCreateCVHeader"
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.title1
        lbl.textColor = .black
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "가장 먼저 떠오르는\n커다란 마음을 골라주세요"
        lbl.isUserInteractionEnabled = true
        //    lbl.adjustsFontSizeToFitWidth = true
        //    lbl.minimumScaleFactor = 0.5
        return lbl
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
        
        setConstraints()
    }
    
    private func setConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
            make.trailing.equalToSuperview()
        }
    }

}
