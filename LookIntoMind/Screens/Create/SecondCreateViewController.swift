//
//  SecondCreateViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/19.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SecondCreateViewController: UIViewController {
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
    var mainCategory: MainCategory
    var loadData: DataModel?
    var selectedCategory: String? {
        didSet {
            if selectedCategory != nil && selectedCategory?.count ?? 0 > 0 {
                nextBtn.isEnabled = true
                nextView.backgroundColor = .black
                SaveData.subCategory = selectedCategory
            }
        }
    }
    var subCategory: [String]
    var todayDate: Date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(loadData: DataModel?, mainCategory: MainCategory, todayDate: Date) {
        self.loadData = loadData

        self.mainCategory = mainCategory
        self.subCategory = SubCategory.array[mainCategory] ?? []
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
        collectionView.register(SecondCreateCollectionViewCell.self, forCellWithReuseIdentifier: SecondCreateCollectionViewCell.cellId)
        collectionView.register(SecondCeateCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SecondCeateCollectionReusableView.cellID)
        collectionView.backgroundColor = .clear
        collectionView.contentInset.bottom = 50
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

}
extension SecondCreateViewController {
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
        if let sub = SaveData.subCategory {
            self.selectedCategory = sub
        } else {
            self.selectedCategory = loadData?.subCategory
        }
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        nextBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                if let selectedCategory {
                    self.presentNextVC(loadData: loadData, mainCategory: mainCategory, subCategory: selectedCategory, todayDate: self.todayDate)
                }
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [weak self] res in
                guard let self else { return }
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    func presentNextVC(loadData: DataModel?, mainCategory: MainCategory, subCategory: String, todayDate: Date) {
        let nextVC = ThirdCreateViewController(loadData: loadData, mainCategory: mainCategory, subCategory: subCategory, todayDate: todayDate)
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    private func setNavi() {
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
        
        naviView.progressView.snp.remakeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.top.bottom.leading.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(naviView.snp.bottom)
            make.width.equalTo(110 * 3 + 20)
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

extension SecondCreateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let selectedItem = subCategory[indexPath.row]
        selectedCategory = selectedItem
        return true
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCreateCollectionViewCell.cellId, for: indexPath) as! SecondCreateCollectionViewCell
        cell.configure(with: subCategory[indexPath.row])
        if let sub = SaveData.subCategory {
            if subCategory[indexPath.row] == sub {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.layoutIfNeeded()
            }
        } else {
            if subCategory[indexPath.row] == loadData?.subCategory {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.layoutIfNeeded()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SecondCeateCollectionReusableView.cellID,
                for: indexPath
              ) as? SecondCeateCollectionReusableView else {return UICollectionReusableView()}
        
        header.configure(with: mainCategory.rawValue)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 152 + 90 + 18)
    }
    
}
extension SecondCreateViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategory.count
    }
    //1
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 44)
    }

    //2
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }

    //3
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
}
