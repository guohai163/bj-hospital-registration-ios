//
//  LoginData.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/13.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class LoginData: NSObject, NSCoding {

    
    var mobile:String
    var pass:String
    var cookies:String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("LoginData")
    
    struct PropertyKey {
        static let mobile = "mobile"
        static let pass = "pass"
        static let cookies = "cookies"
    }
    
    //MARK: init
    init?(mobile: String, pass: String, cookies:String) {
        guard !mobile.isEmpty else {
            return nil
        }
        
        guard !pass.isEmpty else {
            return nil
        }
        self.mobile = mobile
        self.pass = pass
        self.cookies = cookies
    }
    
    func getCookies() -> String {
        return self.cookies
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(mobile, forKey: PropertyKey.mobile)
        aCoder.encode(pass, forKey: PropertyKey.pass)
        aCoder.encode(cookies, forKey: PropertyKey.cookies)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let mobile =  aDecoder.decodeObject(forKey: PropertyKey.mobile) as? String
            else {
                return nil
        }
        
        guard let pass = aDecoder.decodeObject(forKey: PropertyKey.pass) as? String
            else {
                return nil
        }
        
        guard  let cookies = aDecoder.decodeObject(forKey: PropertyKey.cookies) as? String else {
            return nil
        }
        
        self.init(mobile: mobile, pass: pass, cookies: cookies)
        
    }
}
