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
        contentView.insertSubview(backImageView, at: 0)
        setConstraints()
    }
    
    private func setConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    func configure(with presentables: [DataModel], date: Date) {
        let record = presentables.filter({$0.date.toString($0.date.summary) == date.toString(date.summary)}).first
        if let presentable = record {
            let isToday = Date().toString(Date().summary) == date.toString(date.summary)
            if isToday {
                backImageView.image = UIImage(named: presentable.category.rawValue)?.withRenderingMode(.alwaysTemplate)
                backImageView.tintColor = BaseColor.black
                self.titleLabel.textColor = UIColor.white
            } else {
                backImageView.image = UIImage(named: presentable.category.rawValue)?.withRenderingMode(.alwaysTemplate)
                backImageView.tintColor = BaseColor.gray5
                self.titleLabel.textColor = BaseColor.gray4
            }
        } else {
            backImageView.image = nil
            self.titleLabel.textColor = BaseColor.gray4
        }
    }
}
