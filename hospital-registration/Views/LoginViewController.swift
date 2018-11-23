//
//  ViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/2.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginService = LoginService()
    
    @IBOutlet weak var CEControl: CorrectErrorControl!
    @IBOutlet weak var MobileTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func checkButton(_ sender: Any) {
        
        CEControl.iconStatues = "correct"
        
        let user = MobileTextField.text
        let pass = PasswordTextField.text

        
        loginService.LoginResutlts(userName: user!, passWord: pass!) {stateCode,cookies in
            print(stateCode)
            print(cookies)
            if (stateCode == 200 ){
                self.performSegue(withIdentifier: "toHospitalListRoad", sender: nil)
            } else {
                let alert = UIAlertController(title: "登录失败", message: "请重新登录", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginService.checkLoginState() {code,msg in
            print(code,msg)
            if (code == 200 ){
                self.performSegue(withIdentifier: "toHospitalListRoad", sender: nil)
            } else {
                
                if (NSKeyedUnarchiver.unarchiveObject(withFile: LoginData.ArchiveURL.path) != nil ) {
                    guard let loginData:LoginData = (NSKeyedUnarchiver.unarchiveObject(withFile: LoginData.ArchiveURL.path) as! LoginData) else {
                        fatalError("load loginData fatal")
                    }
                    self.MobileTextField.text = loginData.mobile
                    self.PasswordTextField.text = loginData.pass
                }

                
                let alert = UIAlertController(title: "登录失败", message: "请重新登录", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                
                
            }
           
        }
        
        
        
//        let Loading = LoadingHospitalService()
//        Loading.getHospitalResults() {_,_ in
//            
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func singUp(_ sender: Any) {
//        performSegue(withIdentifier: "showWebView", sender: self)
        if let url = URL(string: "http://www.bjguahao.gov.cn/reg.htm") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

