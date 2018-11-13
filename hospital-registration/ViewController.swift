//
//  ViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/2.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let loginService = LoginService()
    
    @IBOutlet weak var CEControl: CorrectErrorControl!
    
    @IBAction func checkButton(_ sender: Any) {
        
        CEControl.iconStatues = "correct"
        
        loginService.LoginResutlts(userName: "18500050982", passWord: "3k5fgb4a") {stateCode,cookies in
            print(stateCode)
            print(cookies)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginService.checkLoginState() {_,_ in
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

