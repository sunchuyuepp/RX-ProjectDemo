//
//  MainTabBarViewController.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return [.portrait]
  }
  // MARK: - ViewController life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
}
