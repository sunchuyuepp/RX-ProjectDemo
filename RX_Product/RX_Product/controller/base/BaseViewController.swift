//
//  BaseViewController.swift
//  RX_Product
//
//  Created by sunny on 2019/4/23.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

  var disposeBag: DisposeBag = {
    let bag = DisposeBag()
    return bag
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  func addRightBarItem(_ title:String?, _ img:UIImage?) -> UIButton {
    let b = UIButton()
    if let t = title {
      b.setTitle(t, for: .normal)
    }
    if let img = img {
      b.setImage(img, for: .normal)
    }
    b.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: b)
    return b
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
