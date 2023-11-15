//
//  CalendarCollectionViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/15.
//

import FSCalendar
import UIKit
import RxSwift
import RxCocoa

class CalendarCollectionViewCell: FSCalendarCell {
    var disposeBag = DisposeBag()
    static let cellId = "CalendarCollectionViewCell"
    
    private let backImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray4
        lbl.lineBreakMode = .byWordWrapping
        lbl.font = BaseFont.body2_num
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
//        contentView.insertSubview(backImageView, at: 0)
        addSubview(backImageView)
        addSubview(dateLbl)
        setConstraints()
    }
    
    private func setConstraints() {
//        self.titleLabel.snp.makeConstraints { make in
//            make.center.equalTo(contentView)
//        }
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        self.dateLbl.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    func configure(with presentables: [DataModel], date: Date) {
        dateLbl.text = date.toString(date.day)
        dateLbl.font = BaseFont.body2_num
        let isToday = Date().toString(Date().summary) == date.toString(date.summary)
        let record = presentables.filter({$0.date.toString($0.date.summary) == date.toString(date.summary)}).first
        if let presentable = record {
            if isToday {
                backImageView.image = UIImage(named: presentable.category.rawValue)?.withRenderingMode(.alwaysTemplate)
                backImageView.tintColor = BaseColor.black
                dateLbl.textColor = UIColor.white
            } else {
                backImageView.image = UIImage(named: presentable.category.rawValue)?.withRenderingMode(.alwaysTemplate)
                backImageView.tintColor = BaseColor.gray5
                dateLbl.textColor = BaseColor.black
            }
        } else {
            backImageView.image = nil
            if isToday {
                dateLbl.textColor = BaseColor.black
                dateLbl.font = BaseFont.title2_num
            } else {
                dateLbl.textColor = BaseColor.gray4
            }
        }
    }
}
