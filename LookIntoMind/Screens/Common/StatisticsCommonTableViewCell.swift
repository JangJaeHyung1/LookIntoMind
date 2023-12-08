//
//  StatisticsCommonTableViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/12/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StatisticsCommonTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "StatisticsCommonTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let categoryLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = BaseFont.body3
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let percentLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray3
        lbl.font = BaseFont.body4_num
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let sliderBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray6
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let sliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.black
        view.layer.cornerRadius = 3
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        categoryImageView.image = nil
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
        cellView.addSubview(categoryImageView)
        cellView.addSubview(categoryLbl)
        cellView.addSubview(percentLbl)
        cellView.addSubview(sliderBGView)
        sliderBGView.addSubview(sliderView)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        categoryLbl.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(20)
        }

        percentLbl.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLbl)
            make.trailing.equalTo(sliderBGView)
        }

        sliderBGView.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.trailing).offset(16)
            make.top.equalTo(categoryLbl.snp.bottom).offset(6)
            make.height.equalTo(6)
            make.trailing.equalToSuperview()
        }

        sliderView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0)
        }
    }
    func configure(with category: String, percent: Int, max: Int) {
        categoryImageView.image = UIImage(named: category)
        categoryLbl.text = category
        percentLbl.text = "\(percent)%"
        sliderView.snp.remakeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Double(percent)/Double(max))
        }
        sliderBGView.backgroundColor = percent == 100 ? UIColor.black : BaseColor.gray6
    }
}
