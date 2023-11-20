//
//  CreateCollectionViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class FirstCreateCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "FirstCreateCollectionViewCell"
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.cellView.layer.borderWidth = 2
            }
            else {
                self.cellView.layer.borderWidth = 0
            }
        }
    }
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 0
        return view
    }()
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let lbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = BaseFont.title2
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        //    lbl.adjustsFontSizeToFitWidth = true
        //    lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        //        cellView.setShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        cellView.setShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(imageView)
        cellView.addSubview(lbl)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        lbl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    func configure(with presentable: String) {
        imageView.image = UIImage(named: presentable)
        lbl.text = presentable
    }
}
