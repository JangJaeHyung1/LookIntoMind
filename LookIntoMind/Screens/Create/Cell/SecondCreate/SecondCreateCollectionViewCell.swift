//
//  SecondCreateCollectionViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/19.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SecondCreateCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "SecondCreateCollectionViewCell"
    
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
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private let title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray1
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = BaseFont.body4
        lbl.isUserInteractionEnabled = true
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
        cellView.addSubview(title)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    func configure(with subCategory: String) {
        title.text = subCategory
    }
}
