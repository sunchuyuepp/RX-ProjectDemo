//
//  Repositories.swift
//  RX_Product
//
//  Created by sunny on 2019/4/1.
//  Copyright © 2019 孙楚粤. All rights reserved.
//

import Foundation
import ObjectMapper

class Repositories: BaseMode {
    
    var totalCounts: Int!
    var incompleteResults: Bool!
    var itemss: [Repository]! //本次查询返回的所有仓库集合
    
    override init() {
        totalCounts = 0
        incompleteResults = false
        itemss = []
        super.init()
      
    }
    
    required init?(map: Map) {
        totalCounts = 0
        incompleteResults = false
        itemss = []
        super.init(map: map)
    }
  
    override func mapping(map: Map) {
        totalCounts <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        itemss <- map["items"]
        super.mapping(map: map)
    }
}

class Repository:BaseMode {
    
    var id: Int!
    var name: String!
    var fullName:String!
    var htmlUrl:String!
    var description:String!

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["fullName"]
        htmlUrl <- map["htmlUrl"]
        description <- map["description"]
        super.mapping(map: map)
    }
  
}
