//
//  RXNavigationController.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit

class RXNavigationController: UINavigationController, UIGestureRecognizerDelegate{

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return [.portrait]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.barTintColor = UIColor.init(red: 63/255, green: 68/255, blue: 234/255, alpha: 1)
    navigationBar.isTranslucent = false
    navigationBar.shadowImage = UIImage()
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    interactivePopGestureRecognizer?.isEnabled = true
    interactivePopGestureRecognizer?.delegate = self
  }
  
  // MARK: - UIGestureRecognizerDelegate
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.viewControllers.count > 1
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return gestureRecognizer is UIScreenEdgePanGestureRecognizer
  }

}
