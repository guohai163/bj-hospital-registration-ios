//
//  Department.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/20.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

class Department {
    let id:Int
    let name:String
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - id: 科室编号
    ///   - name: 科室名称
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
}

class Departments {
    let category:String
    let department:[Department]
    
    init(category:String, department:[Department]) {
        self.category = category
        self.department = department
    }
}
