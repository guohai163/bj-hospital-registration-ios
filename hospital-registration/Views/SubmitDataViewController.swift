//
//  SubmitDataViewController.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/22.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

class SubmitDataViewController: UIViewController {

    
    @IBOutlet weak var selectDate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let date = UIDatePicker()
        date.datePickerMode = .date
        date.locale = Locale(identifier: "zh_cn")
        date.addTarget(self, action: #selector(getDate), for: UIControl.Event.valueChanged)
        selectDate.inputView = date
        
        //use toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40))
        let doneBarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexibleSpace,doneBarBtn], animated: true)
        selectDate.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donePressed() {
        selectDate.resignFirstResponder()
    }
    
    @objc func getDate(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        let date = datePicker.date
        formatter.dateFormat = "YYY-MM-dd"
        let dateStr = formatter.string(from: date)
        self.selectDate.text = dateStr
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
