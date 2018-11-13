//
//  LoginService.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/12.
//  Copyright © 2018 gh. All rights reserved.
//

import Foundation

class LoginService {
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (Int, String) -> ()
    
    let defaultSession = URLSession.shared
    
    var dataTask: URLSessionDataTask? = nil
    
    func LoginResutlts(userName: String, passWord: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        let url = URL(string: "http://www.bjguahao.gov.cn/quicklogin.htm")
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:62.0) Gecko/20100101 Firefox/62.0", forHTTPHeaderField:"User-Agent")
        request.setValue("application/json text/javascript */*; q=0.01", forHTTPHeaderField:"Accept")
        request.setValue("zh-CNzh;q=0.8zh-TW;q=0.7zh-HK;q=0.5en-US;q=0.3en;q=0.2", forHTTPHeaderField: "Accept-Language")
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("gzip deflate", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.setValue("http://www.bjguahao.gov.cn/logout.htm", forHTTPHeaderField: "Referer")
        request.setValue("http://www.bjguahao.gov.cn", forHTTPHeaderField: "Origin")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")


        let postData = "mobileNo=\(base64Encoding(plainString: userName))&password=\(base64Encoding(plainString: passWord))&yzm=&isAjax=true".data(using: String.Encoding.utf8)

        request.httpBody = postData
        let postLength=String(format: "%ld", postData!.count)
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        dataTask = defaultSession.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            } else if let response = response as? HTTPURLResponse,
            response.statusCode == 200   {
                var responseData: JSONDictionary?
                do {
                    responseData = try JSONSerialization.jsonObject(with: data!, options: []) as? JSONDictionary
                } catch let parseError as NSError {
                    print( "JSONSerialization error: \(parseError.localizedDescription)\n")
                    return
                }
                var cookies:String = ""
                if(responseData!["code"] as! Int == 200 ){
                    cookies = response.allHeaderFields["Set-Cookie"] as! String
                    cookies = cookies.replacingOccurrences(of: "Path=/; HttpOnly,", with: "", options: String.CompareOptions.literal, range: nil)
                    cookies = cookies.replacingOccurrences(of: "path=/", with: "", options: String.CompareOptions.literal, range: nil)
                    
                    guard let loginData = LoginData(mobile: userName, pass: passWord, cookies: cookies)
                        else {
                            fatalError("init loginData fatal")
                    }
                    NSKeyedArchiver.archiveRootObject(loginData, toFile: LoginData.ArchiveURL.path)
                }
                DispatchQueue.main.sync {
                    completion(responseData!["code"] as! Int ,cookies )
                }
            }
            
        }
        dataTask?.resume()

        
    }
    
    func checkLoginState(completion: @escaping QueryResult) {
        guard let loginData:LoginData = (NSKeyedUnarchiver.unarchiveObject(withFile: LoginData.ArchiveURL.path) as! LoginData) else {
            fatalError("load loginData fatal")
        }
        print(loginData)
        dataTask?.cancel()
        //
        let url = URL(string: "http://www.bjguahao.gov.cn/islogin.htm")
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:62.0) Gecko/20100101 Firefox/62.0", forHTTPHeaderField:"User-Agent")
        request.setValue("application/json text/javascript */*; q=0.01", forHTTPHeaderField:"Accept")
        request.setValue("zh-CNzh;q=0.8zh-TW;q=0.7zh-HK;q=0.5en-US;q=0.3en;q=0.2", forHTTPHeaderField: "Accept-Language")
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("gzip deflate", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.setValue("http://www.bjguahao.gov.cn/index.htm", forHTTPHeaderField: "Referer")
        request.setValue("http://www.bjguahao.gov.cn", forHTTPHeaderField: "Origin")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue(loginData.cookies , forHTTPHeaderField: "Cookie")
        
        let postData = "isAjax=true".data(using: String.Encoding.utf8)
        request.httpBody = postData
        let postLength=String(format: "%ld", postData!.count)
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        
        dataTask = defaultSession.dataTask(with: request as URLRequest) { data, response, error in

            if let error = error {
                print ("error: \(error)")
                return
            } else if let response = response as? HTTPURLResponse,
                response.statusCode == 200   {
                var responseData: JSONDictionary?
                do {
                    responseData = try JSONSerialization.jsonObject(with: data!, options: []) as? JSONDictionary
                } catch let parseError as NSError {
                    print( "JSONSerialization error: \(parseError.localizedDescription)\n")
                    return
                }
                DispatchQueue.main.sync {
                    completion(responseData!["code"] as! Int,responseData!["msg"] as! String)
                }
                
            }
        }
        dataTask?.resume()
        
    }
    
    func  base64Encoding(plainString: String) -> String {
        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
}
