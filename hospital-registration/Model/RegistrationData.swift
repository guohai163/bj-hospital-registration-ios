//
//  RegistrationData.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/22.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

class RegistrationData {
    let hospitalId:Int
    let departmentId:Int
    let dutyDate:String
    var doctorId:Int = 0
    var dutySourceId:Int = 0
    
    init(hospitalId:Int, departmentId:Int, dutyDate:String) {
        self.hospitalId = hospitalId
        self.departmentId = departmentId
        self.dutyDate = dutyDate
    }
}
