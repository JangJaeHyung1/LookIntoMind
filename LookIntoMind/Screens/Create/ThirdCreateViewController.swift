//
//  ThirdCreateViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/21.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ThirdCreateViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let naviView: NaviView = {
        let view = NaviView()
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
    
    private let completeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.isEnabled = false
        btn.titleLabel?.font = BaseFont.body2_long
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(BaseColor.gray4, for: .disabled)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
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
    
    private let subGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.gray3
        lbl.font = BaseFont.body4
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "천천히 곱씹은 내 마음은"
        lbl.isUserInteractionEnabled = true
        return lbl
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
        tv.textColor = BaseColor.gray4
        tv.font = BaseFont.body2_long
        tv.setLineSpacing(lineSpacing: 9)
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
    
    private let keyboradDownView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.isHidden = true
        return view
    }()
    
    private let keyboardLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray5
        return view
    }()
    
    private let keyboardDownBtn: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.setImage(UIImage(named: "keyboard_down"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    var mainCategory: MainCategory
    var subCategory: String
    var todayDate: Date
    var loadData: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(loadData: DataModel?, mainCategory: MainCategory, subCategory: String, todayDate: Date) {
        self.loadData = loadData
        self.mainCategory = mainCategory
        self.subCategory = subCategory
        self.todayDate = todayDate
        
        self.subCategoryLbl.text = subCategory
        self.categoryImageView.image = UIImage(named: mainCategory.rawValue)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ThirdCreateViewController {
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
        dateLbl.text = Date().toString(Date().summary)
        setupKeyboardEvent()
        var content = ""
        
        if let temp = SaveData.content {
            if temp.count > 0 {
                content = temp
            }
        } else {
            if let temp = loadData?.content {
                if temp.count > 0 {
                    content = temp
                }
            }
        }
        
        if content.count > 0 && content != "오늘 마음을 들여다보아요" {
            textView.text = content
            textView.textColor = BaseColor.black
            completeBtn.isEnabled = true
        } else {
            textView.text = "오늘 마음을 들여다보아요"
        }
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        textSetUp()
        
        textView.rx.text.changed
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                
                self.completeBtn.isEnabled = res?.count ?? 0 > 0
            })
            .disposed(by: disposeBag)
        
        keyboardDownBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.textView.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        completeBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                Task {
                    let toRecordData = DataModel(date: self.todayDate, category: self.mainCategory, subCategory: self.subCategory, content: self.textView.text)
                    _ = try RealmAPI.shared.save(item: toRecordData)
                    _ = try RealmAPI.shared.deleteTemp()
                    self.back(page: 4)
                }
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                if let content = textView.text {
                    SaveData.content = self.textView.text
                }
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        view.addSubview(naviView)
        naviView.addSubview(completeBtn)
        naviView.addSubview(dateLbl)
        
        view.addSubview(categoryBGView)
        categoryBGView.addSubview(categoryImageView)
        categoryBGView.addSubview(subGuideLbl)
        categoryBGView.addSubview(subCategoryLbl)
        
        view.addSubview(textView)
        view.addSubview(keyboradDownView)
        keyboradDownView.addSubview(keyboardLineView)
        keyboradDownView.addSubview(keyboardDownBtn)
    }
    
    private func setConstraints() {
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        dateLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(completeBtn)
        }
        
        completeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        naviView.progressView.snp.remakeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1)
            make.top.bottom.leading.equalToSuperview()
        }
        
        categoryBGView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(naviView.snp.bottom)
            make.height.equalTo(150 + 40 + 40)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        subGuideLbl.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(16 )
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        subCategoryLbl.snp.makeConstraints { make in
            make.top.equalTo(subGuideLbl.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(categoryBGView.snp.bottom)
            make.bottom.equalTo(keyboradDownView.snp.top).offset(44)
        }
        
        keyboradDownView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        keyboardLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(2)
        }
        
        keyboardDownBtn.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        
        
    }
    
    func textSetUp(){
            textView.rx.didBeginEditing
                .subscribe(onNext: { [self] in
                if(textView.text == "오늘 마음을 들여다보아요"){
                    textView.text = nil
                    textView.textColor = BaseColor.black
                }}).disposed(by: disposeBag)
            
            textView.rx.didEndEditing
                .subscribe(onNext: { [self] in
                if(textView.text == nil || textView.text == ""){
                    textView.text = "오늘 마음을 들여다보아요"
                    textView.textColor = BaseColor.gray4
                }}).disposed(by: disposeBag)
        }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.categoryBGView.snp.updateConstraints({ make in
                make.height.equalTo(0)
            })
        }
        view.layoutIfNeeded()
        keyboradDownView.isHidden = false
        textView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(categoryBGView.snp.bottom)
            make.bottom.equalTo(keyboradDownView.snp.top).offset(0)
        }
        textView.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.categoryBGView.snp.updateConstraints({ make in
                make.height.equalTo(150 + 40 + 40)
            })
        }
        view.layoutIfNeeded()
        keyboradDownView.isHidden = true
        textView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(categoryBGView.snp.bottom)
            make.bottom.equalTo(keyboradDownView.snp.top).offset(44)
        }
        textView.layoutIfNeeded()
    }
}
