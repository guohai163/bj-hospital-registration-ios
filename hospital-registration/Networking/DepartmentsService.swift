//
//  DepartmentsService.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/20.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

class DepartmentsService {
    
    typealias JSONDictionary = [String: Any]
    /// URL会话
    let defaultSession = URLSession(configuration: .default)
    /// 数据对象
    var dataTask:URLSessionDataTask?
    
    var departments:[Departments] = []
    
    
    func loadingDepartments(hospitalId:Int) {
        dataTask?.cancel()
        
        if var urlComponetns = URLComponents(string: "http://www.bjguahao.gov.cn/dpt/dpts.htm") {
            urlComponetns.query = "hospitalId=\(hospitalId)&hospitalType=1&isAjax=true"
            guard let url = urlComponetns.url else {return}
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateResults(data)
//                    DispatchQueue.main.async {
//                        completion(self.tracks, "")
//                    }
                }
            }
            dataTask?.resume()
            
        }
    }
    
    fileprivate func updateResults(_ data: Data) {
        var response: JSONDictionary?
        departments.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print(parseError)
            return
        }
        
        guard let array = response!["data"] as? [Any] else {
            return
        }
        for departs in array {
            
            let departs = departs as? JSONDictionary
            let categoryName = departs?["sdCategoryFirstName"] as? String
            print(categoryName)
            
            if let departms = departs!["departments"] as? [Any] {
                var deObj:[Department] = []
                for depar in departms {
                    let depar = depar as? JSONDictionary
                    deObj.append(Department.init(id: (depar!["id"] as? Int)!, name: (depar!["name"] as? String)!))
                }
                departments.append(Departments.init(category: categoryName!, department: deObj))
            }
            
        }

        for a in departments {
            print(a.category)
            for b in a.department {
                print(b.id,b.name)
            }
        }
    }
}
