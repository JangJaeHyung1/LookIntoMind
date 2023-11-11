//
//  ViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/05.
//

import UIKit
import RxSwift
import RxCocoa

class TabbarViewController: UITabBarController  {
    private let safeLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.gray7
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        self.selectedIndex = 1
        overrideUserInterfaceStyle = .light
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.safeAreaInsets.bottom > 10 {
            tabBar.frame.size.height = 88
            tabBar.frame.origin.y = view.frame.height - 88
        } else {
            tabBar.frame.size.height = 54
            tabBar.frame.origin.y = view.frame.height - 54
        }
    }
    
}

extension TabbarViewController {
    private func setUp() {
        setTabBar()
        setupStyle()
        setNavi()
        setSafeLayoutGuideView()
    }
    
    private func setSafeLayoutGuideView() {
        view.addSubview(safeLayoutView)
        self.safeLayoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.safeLayoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.safeLayoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.safeLayoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    private func setupStyle() {
        UITabBar.clearShadow()
//        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    private func setTabBar(){
        
        let vc1 = CalenderViewController()
        let vc2 = MainViewController()
        let vc3 = RecordsViewController()
        
        self.setViewControllers([vc1,vc2,vc3], animated: false)
        
        guard let items = self.tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        let itemsImage = ["calender_unselected", "main_unselected","records_unselected"]
        let selectedImages = ["calender_selected", "main_selected","records_selected"]
        for x in 0...2 {
            let image = UIImage(named: itemsImage[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
            
            let selectedImage = UIImage(named: selectedImages[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
            
            items[x].image = image?.withRenderingMode(.alwaysOriginal)
            items[x].selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        self.tabBar.unselectedItemTintColor = .systemGray6
        self.tabBar.tintColor = .black
    }
    
}
