//
//  LoadingHospital.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/14.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

/// 医院加载类
class LoadingHospitalService{
    
    typealias QueryResult = ([Track]?, String) -> ()
    typealias JSONDictionary = [String: Any]
    
    var tracks:[Track] = []
    
    /// URL会话
    let defaultSession = URLSession(configuration: .default)
    /// 数据对象
    var dataTask:URLSessionDataTask?
    
    /// 获得完整的医院列表
    ///
    /// - Parameter completion: 回调方法
    func getHospitalResults(completion: @escaping QueryResult) {
        dataTask?.cancel()
        //http://www.bjguahao.gov.cn/hp/qsearch.htm?areaId=-1&levelId=-1&isAjax=true
        
        if var urlComponetns = URLComponents(string: "http://www.bjguahao.gov.cn/hp/qsearch.htm") {
            urlComponetns.query = "areaId=-1&levelId=-1&isAjax=true"
            guard let url = urlComponetns.url else {return}
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateTableViewResults(data)
                    DispatchQueue.main.async {
                        completion(self.tracks, "")
                    }
                }
                
            }
            
            dataTask?.resume()
        }
        
    }
    
    /// 更新TableView
    ///
    /// - Parameter data: 待处理的数据
    fileprivate func updateTableViewResults(_ data:Data) {
        var response:JSONDictionary?
        
        tracks.removeAll()
        
        do{
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print(parseError)
            return
        }
        
        guard let array = response!["data"] as? [Any] else {
            print("转换失败")
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let id = trackDictionary["id"] as? Int,
                let name = trackDictionary["name"] as? String {
                tracks.append(Track(name: name, id: id, index: index))
                index += 1
            } else {
                
            }
        }
     }
}
