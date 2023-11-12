//
//  EmptyTableViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/11.
//

import UIKit
import RxSwift
import RxCocoa

class EmptyTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "EmptyTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray4
        lbl.font = BaseFont.body2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "마음 쉼"
        lbl.isUserInteractionEnabled = true
        return lbl
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
        cellView.addSubview(titleLbl)
        
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 92).isActive = true
        titleLbl.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
