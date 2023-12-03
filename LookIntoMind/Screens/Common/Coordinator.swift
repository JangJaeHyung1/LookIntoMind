////
////  Coordinator.swift
////  LookIntoMind
////
////  Created by jh on 2023/11/23.
////
//
//import UIKit
//
//protocol Coordinator {
//    func start()
//}
//
//
//final class DefaultAppCoordinator: Coordinator {
//    var navigationController: UINavigationController
//
//    init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
////        navigationController.setNavigationBarHidden(true, animated: true)
//    }
//
//    func start() {
////        self.showTabBarFlow()
//        let vc = TabbarViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//
//    }
//
//
//    func showTabBarFlow() {
//        let tabBarCoordinator = DefaultTabBarCoordinator(navigationController: self.navigationController)
//        tabBarCoordinator.start()
//    }
//}
//
//
//final class DefaultTabBarCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var childCoordinators: [Coordinator] = []
//    var tabBarController: UITabBarController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = UITabBarController()
//        navigationController.setNavigationBarHidden(true, animated: true)
//    }
//
//    func start() {
//        let pages: [TabBarPage] = TabBarPage.allCases
//        let controllers: [UINavigationController] = pages.map({
//            self.createTabNavigationController(of: $0)
//        })
//        self.configureTabBarController(with: controllers)
//    }
//
//    func selectPage(_ page: TabBarPage) {
//        self.tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//
//    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
//        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
//        self.tabBarController.selectedIndex = TabBarPage.main.pageOrderNumber()
//    }
//
//    private func configureTabBarItem(of page: TabBarPage) -> UITabBarItem {
//        return UITabBarItem(
//
////
////            for item in items {
////                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
////            }
////            let itemsImage = ["calender_unselected", "main_unselected","records_unselected"]
////            let selectedImages = ["calender_selected", "main_selected","records_selected"]
////            for x in 0...2 {
////                let image = UIImage(named: itemsImage[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
////
////                let selectedImage = UIImage(named: selectedImages[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
////
////                items[x].image = image?.withRenderingMode(.alwaysOriginal)
////                items[x].selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
////            }
////
////            self.tabBar.unselectedItemTintColor = .systemGray6
////            self.tabBar.tintColor = .black
//
//
//            title: nil,
//            image: UIImage(named: page.tabIconName()),
//            tag: page.pageOrderNumber()
//        )
//    }
//
//    private func createTabNavigationController(of page: TabBarPage) -> UINavigationController {
//        let tabNavigationController = UINavigationController()
//
//        tabNavigationController.setNavigationBarHidden(false, animated: false)
//        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
//        self.startTabCoordinator(of: page, to: tabNavigationController)
//        return tabNavigationController
//    }
//
//    private func startTabCoordinator(of page: TabBarPage, to tabNavigationController: UINavigationController) {
//        switch page {
//        case .calandar:
//            let calendarCoordinator = CalendarCoordinator(navigationController: navigationController)
//            calendarCoordinator.start()
//        case .main:
//            let mainCoordinator = MainCoordinator(navigationController: navigationController, loadData: nil)
//            mainCoordinator.start()
//        case .statistics: let statisticsCoordinator = StatisticsCoordinator(navigationController: navigationController)
//            statisticsCoordinator.start()
//        }
//    }
//}
//
//
//class CalendarCoordinator: Coordinator {
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let vc = CalendarViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//}
//
//
//class MainCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var loadData: DataModel?
//
//    init(navigationController: UINavigationController, loadData: DataModel?) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let vc = MainViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func showCreateVC(for loadData: DataModel?) {
//        let nextCoordinator = FirstCreateCoordinator(navigationController: navigationController, loadData: loadData)
//        nextCoordinator.start()
//    }
//    func showRecordVC(mainCategory: MainCategory, subCategory: String, content: String) {
//        let nextVC = RecordsCoordinator(navigationController: navigationController, mainCategory: mainCategory, subCategory: subCategory, content: content)
//        nextVC.start()
//    }
//}
//
//
//class StatisticsCoordinator: Coordinator {
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let vc = StatisticsViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//}
//
//
//class FirstCreateCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var loadData: DataModel?
//
//    init(navigationController: UINavigationController, loadData: DataModel?) {
//        self.navigationController = navigationController
//        self.loadData = loadData
//    }
//
//    func start() {
//        let vc = FirstCreateViewController(loadData: loadData)
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func showNextVC(for loadData: DataModel?, mainCategory: MainCategory) {
//        let nextCoordinator = SecondCreateCoordinator(navigationController: navigationController, loadData: loadData, mainCategory: mainCategory)
//        nextCoordinator.start()
//    }
//}
//
//
//class SecondCreateCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var loadData: DataModel?
//    var mainCategory: MainCategory
//
//    init(navigationController: UINavigationController, loadData: DataModel?, mainCategory: MainCategory) {
//        self.navigationController = navigationController
//        self.loadData = loadData
//        self.mainCategory = mainCategory
//    }
//
//    func start() {
//        let vc = SecondCreateViewController(loadData: loadData, mainCategory: mainCategory)
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func showNextVC(loadData: DataModel?, mainCategory: MainCategory, subCategory: String) {
//        let nextVC = ThirdCreateCoordinator(navigationController: navigationController, loadData: loadData, mainCategory: mainCategory, subCategory: subCategory)
//        nextVC.start()
//    }
//}
//
//
//class ThirdCreateCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var loadData: DataModel?
//    var mainCategory: MainCategory
//    var subCategory: String
//
//    init(navigationController: UINavigationController, loadData: DataModel?, mainCategory: MainCategory, subCategory: String) {
//        self.navigationController = navigationController
//        self.loadData = loadData
//        self.mainCategory = mainCategory
//        self.subCategory = subCategory
//    }
//
//    func start() {
//        let vc = ThirdCreateViewController(loadData: loadData, mainCategory: mainCategory, subCategory: subCategory)
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func showNextVC(loadData: DataModel?, mainCategory: MainCategory, subCategory: String, content: String) {
//        let nextVC = RecordsCoordinator(navigationController: navigationController, mainCategory: mainCategory, subCategory: subCategory, content: content)
//        nextVC.start()
//    }
//}
//
//class RecordsCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    var mainCategory: MainCategory
//    var subCategory: String
//    var content: String
//
//    init(navigationController: UINavigationController, mainCategory: MainCategory, subCategory: String, content: String) {
//        self.navigationController = navigationController
//        self.mainCategory = mainCategory
//        self.subCategory = subCategory
//        self.content = content
//    }
//
//    func start() {
//        let vc = RecordsViewController( mainCategory: mainCategory, subCategory: subCategory, content: content)
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }
//}
//
