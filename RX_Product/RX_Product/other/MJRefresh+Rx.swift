//
//  MJRefresh+Rx.swift
//  RX_Product
//
//  Created by sunny on 2019/4/24.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import RxSwift
import RxCocoa

//对MJRefreshComponent增加rx扩展
extension Reactive where Base: MJRefreshComponent {
  
  //正在刷新事件
  var refreshing: ControlEvent<Void> {
    let source: Observable<Void> = Observable.create {
      [weak control = self.base] observer  in
      if let control = control {
        control.refreshingBlock = {
          observer.on(.next(()))
        }
      }
      return Disposables.create()
    }
    return ControlEvent(events: source)
  }
  
  //停止刷新
  var endRefreshing: Binder<Bool> {
    return Binder(base) { refresh, isEnd in
      if isEnd {
        refresh.endRefreshing()
      }
    }
  }
}
