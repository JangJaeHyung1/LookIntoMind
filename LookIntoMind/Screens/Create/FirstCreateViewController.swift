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

class FirstCreateViewController: UIViewController {

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
    
    var loadData: DataModel?
    var selectedCategory: MainCategory? {
        didSet {
            nextBtn.isEnabled = true
            nextView.backgroundColor = .black
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
    
    init(loadData: DataModel?) {
        self.loadData = loadData
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
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        
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
