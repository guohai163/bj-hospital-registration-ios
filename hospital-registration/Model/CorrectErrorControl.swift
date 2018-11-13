//
//  CorrectErrorControl.swift
//  hospital-registration
//
//  Created by 郭海 on 2018/11/12.
//  Copyright © 2018 gh. All rights reserved.
//

import UIKit

 @IBDesignable class CorrectErrorControl: UIStackView {
    
    private var checkImage = UIImageView()
    
    @IBInspectable var iconStatues:String = "null" {
        didSet {
            setupImage()
        }
    }
    
    override init(frame: CGRect) {
        print(frame)
        super.init(frame: frame)
        setupImage()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupImage()
    }
    
    private func setupImage() {
        removeArrangedSubview(checkImage)
        checkImage.removeFromSuperview()
        
        if(iconStatues != "null") {
            let bundle = Bundle(for: type(of: self))
            
            let image = UIImage(named: iconStatues, in: bundle, compatibleWith: self.traitCollection)!
            
            checkImage = UIImageView(image: image)
            checkImage.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            
            checkImage.contentMode = .scaleAspectFit
            addArrangedSubview(checkImage)
        }


    }
    

}
