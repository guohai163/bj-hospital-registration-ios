//
//  WebViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/22.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {


    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string:"http://www.bjguahao.gov.cn/reg.htm") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
