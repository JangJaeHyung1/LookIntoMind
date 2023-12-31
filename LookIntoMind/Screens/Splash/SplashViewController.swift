//
//  SplashViewController.swift
//  LookIntoMind
//
//  Created by jh on 2023/11/17.
//

import UIKit
import Gifu
import SnapKit

class SplashViewController: UIViewController {
    private let gifImage: GIFImageView = {
        let img = GIFImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(gifImage)
        gifImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        gifImage.animate(withGIFNamed: "Splash")
        Timer.scheduledTimer(withTimeInterval: 1.6, repeats: false, block: {[weak self] timer in
            // todo 0.1 -> 1.6s
            self?.gifImage.stopAnimatingGIF()
            self?.goMain()
        })
    }
    
    func goMain() {
        let Storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let VC = Storyboard.instantiateViewController(identifier: "Main") as? TabbarViewController else { return }
        let navigationController = UINavigationController(rootViewController: VC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
        
    }
}
