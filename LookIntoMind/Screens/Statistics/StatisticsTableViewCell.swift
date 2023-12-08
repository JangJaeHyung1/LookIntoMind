//
//  StatisticsTableViewCell.swift
//  LookIntoMind
//
//  Created by jh on 2023/12/08.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StatisticsTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "StatisticsTableViewCell"

    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        return view
    }()
    
    private let calendarLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = BaseColor.gray4
        lbl.font = BaseFont.title2
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let arrowImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrow_right")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let nextBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tableView: UITableView!
    
    var sortedDictionary: [Dictionary<MainCategory, Int>.Element] = [] {
        didSet {
            let count = sortedDictionary.count > 5 ? 5 : sortedDictionary.count
            tableView.snp.updateConstraints { make in
                make.height.equalTo((16 + 40) * count)
            }
            tableView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTableView()
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

    private func setTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StatisticsCommonTableViewCell.self, forCellReuseIdentifier: StatisticsCommonTableViewCell.cellId)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(calendarLbl)
        cellView.addSubview(arrowImage)
        cellView.addSubview(nextBtn)
        cellView.addSubview(tableView)
        setConstraints()
    }

    private func setConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        calendarLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.width.height.equalTo(14)
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalTo(calendarLbl)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nextBtn.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(0)
        }
    }
    func configure(with presentable: [Dictionary<MainCategory, Int>.Element], date: String) {
        sortedDictionary = presentable
        calendarLbl.text = date
    }
}

extension StatisticsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = sortedDictionary.count > 5 ? 5 : sortedDictionary.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCommonTableViewCell.cellId, for: indexPath) as! StatisticsCommonTableViewCell
        cell.selectionStyle = .none
        let category: String = "\(sortedDictionary[indexPath.row].key.rawValue)"
        let percent: Int = sortedDictionary[indexPath.row].value
        cell.configure(with: category, percent: percent, max: sortedDictionary[0].value)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
