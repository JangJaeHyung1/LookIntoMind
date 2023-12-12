//
//  RecordsViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RecordsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var naviView: NaviView = {
        let view = NaviView(backBtnEnable: backEnable)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = BaseFont.title2_num
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let categoryBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray7
        return view
    }()
    
    private let categoryImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    private let subCategoryLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = .black
        lbl.font = BaseFont.title1_sub
        lbl.lineBreakMode = .byWordWrapping
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.textColor = BaseColor.gray1
        tv.isEditable = false
        tv.font = BaseFont.body2_long
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.smartDashesType = .no
        tv.smartQuotesType = .no
        tv.smartInsertDeleteType = .no
        tv.spellCheckingType = .no
        tv.contentInset = .init(top: 24, left: 0, bottom: 24, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var mainCategory: MainCategory
    var subCategory: String
    var recordDate: Date
    var backEnable: Bool
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(mainCategory: MainCategory, subCategory: String, content: String, recordDate: Date, backEnable: Bool) {
        self.mainCategory = mainCategory
        self.subCategory = subCategory
        
        self.subCategoryLbl.text = subCategory
        self.categoryImageView.image = UIImage(named: mainCategory.rawValue)
        self.recordDate = recordDate
        self.backEnable = backEnable
        
        self.textView.text = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RecordsViewController {
    private func setUp() {
        configure()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
        
    }
    private func configure() {
        view.backgroundColor = .white
        dateLbl.text = recordDate.summary
        textView.setLineSpacing(lineSpacing: 9)
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        naviView.dismissBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.progressBGView.isHidden = true
        naviView.progressView.isHidden = true
    }
    
    private func addViews() {
        view.addSubview(naviView)
        naviView.addSubview(dateLbl)
        
        view.addSubview(categoryBGView)
        categoryBGView.addSubview(categoryImageView)
        categoryBGView.addSubview(subCategoryLbl)
        
        view.addSubview(textView)
    }
    
    private func setConstraints() {
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        dateLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(naviView.backBtn)
        }
        
        categoryBGView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(naviView.snp.bottom).offset(-4)
            make.height.equalTo(125 + 40 + 40)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        subCategoryLbl.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(categoryBGView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
}
