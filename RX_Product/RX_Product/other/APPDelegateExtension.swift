//
//  APPDelegateExtension.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit

extension AppDelegate {
  func initRoot() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    let rootVC = MainTabBarViewController()
    let homeVC = HomeViewController()
    let personalVC = PersonalProfileViewController()
    rootVC.viewControllers = [RXNavigationController(rootViewController: homeVC),RXNavigationController(rootViewController: personalVC)]
    window?.rootViewController = rootVC
  }
}
