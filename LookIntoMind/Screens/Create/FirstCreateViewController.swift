//
//  RecordFirstViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RealmSwift

class FirstCreateViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var collectionView: UICollectionView!
    
    private let naviView: NaviView = {
        let view = NaviView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    private let nextBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    private let nextView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.gray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nextBtnLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = .white
        lbl.font = BaseFont.body2
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "다음"
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton()
        btn.isEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    var todayDate: Date
    var loadData: DataModel?
    var selectedCategory: MainCategory? {
        didSet {
            if selectedCategory != nil {
                nextBtn.isEnabled = true
                nextView.backgroundColor = .black
                // 임시 저장할 데이터 저장하기
                SaveData.category = selectedCategory
                if loadData?.category != selectedCategory {
                    // 임시 저장된 데이터 초기화
                    SaveData.subCategory = nil
                    loadData?.subCategory = ""
                }
            }
        }
    }
    var category: [String] = [
        MainCategory.wonder.rawValue,
        MainCategory.pleasure.rawValue,
        MainCategory.sympathy.rawValue,
        
        MainCategory.interest.rawValue,
        MainCategory.affection.rawValue,
        MainCategory.worry.rawValue,
        
        MainCategory.fear.rawValue,
        MainCategory.anger.rawValue,
        MainCategory.embarrassment.rawValue,
        
        MainCategory.sorry.rawValue,
        MainCategory.hate.rawValue,
        MainCategory.discomfort.rawValue,
        
        MainCategory.shame.rawValue,
        MainCategory.sadness.rawValue,
        MainCategory.regret.rawValue,
        
        MainCategory.disgust.rawValue,
        MainCategory.wind.rawValue,
        MainCategory.boredom.rawValue,
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(loadData: DataModel?, todayDate: Date) {
        self.loadData = loadData
        self.todayDate = todayDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FirstCreateCollectionViewCell.self, forCellWithReuseIdentifier: FirstCreateCollectionViewCell.cellId)
        collectionView.register(FirstCreateCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FirstCreateCVHeader.cellID)
        collectionView.backgroundColor = .clear
        collectionView.contentInset.bottom = 50
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

}
extension FirstCreateViewController {
    private func setUp() {
        setCollectionView()
        configure()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    private func configure() {
        view.backgroundColor = BaseColor.gray7
        SaveData.date = Date()
        self.selectedCategory = loadData?.category
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        nextBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                if let mainCategory = selectedCategory {
                    self.presentNextVC(loadData: loadData, mainCategory: mainCategory, todayDate: self.todayDate)
                }
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                // 모달 띄우기
                
                if selectedCategory != nil {
                    self.presentModal()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    private func presentModal() {
        let sheet = UIAlertController(title: "일기를 임시저장하시겠어요?", message: nil, preferredStyle: .alert)

        let leftAlert = UIAlertAction(title: "저장안함", style: .destructive, handler: {[weak self] _ in
            guard let self = self else { return }
            Task {
                _ = try RealmAPI.shared.deleteTemp()
                self.navigationController?.popViewController(animated: true)
            }
        })
        let rightAlert = UIAlertAction(title: "이어서 쓰기", style: .default, handler: {[weak self] _ in
            guard let self = self else { return }
            Task {
                guard let date = SaveData.date, let mainCategory = SaveData.category else { return }
                try RealmAPI.shared.tempSave(item: SaveDataModel(date: date, category: mainCategory, subCategory: SaveData.subCategory, content: SaveData.content))
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        leftAlert.setValue(BaseColor.gray3, forKey: "titleTextColor")
        rightAlert.setValue(BaseColor.black, forKey: "titleTextColor")
        sheet.addAction(leftAlert)
        sheet.addAction(rightAlert)

        present(sheet, animated: true)
    }
    
    private func setNavi() {
        
    }
    
    func presentNextVC(loadData: DataModel?, mainCategory: MainCategory, todayDate: Date) {
        let nextVC = SecondCreateViewController(loadData: loadData, mainCategory: mainCategory, todayDate: todayDate)
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(collectionView)
        
        view.addSubview(nextBGView)
        nextBGView.addSubview(nextView)
        nextView.addSubview(nextBtnLbl)
        nextView.addSubview(nextBtn)
    }
    
    private func setConstraints() {
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(naviView.snp.bottom)
            make.width.equalTo(104 * 3 + 30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextBGView.snp.top)
        }
        
        nextBGView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32 - 56)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(56)
        }

        nextBtnLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FirstCreateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let key = category[indexPath.row]
        selectedCategory = MainCategory(rawValue: key)
        return true
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCreateCollectionViewCell.cellId, for: indexPath) as! FirstCreateCollectionViewCell
        cell.configure(with: category[indexPath.row])
        if category[indexPath.row] == loadData?.category.rawValue {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.layoutIfNeeded()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: FirstCreateCVHeader.cellID,
                    for: indexPath
                  ) as? FirstCreateCVHeader else {return UICollectionReusableView()}

            return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 152)
    }
    
}
extension FirstCreateViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    //1
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 120)
    }

    //2
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }

    //3
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }
}
