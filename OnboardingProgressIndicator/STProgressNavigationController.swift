//
//  STProgressNavigationController.swift
//  OnboardingProgressIndicator
//
//  Created by Camille Kander on 6/10/15.
//  Copyright (c) 2015 Sproutling. All rights reserved.
//

import UIKit

class STProgressNavigationController: UINavigationController {

    let progressBar = STOnboardingProgressView()
    let extraHeight = CGFloat(16.0)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar .addSubview(self.progressBar)
        self.progressBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        for attribute in [NSLayoutAttribute.Leading, .Trailing,] {
            self.navigationBar.addConstraint(NSLayoutConstraint(item: self.progressBar, attribute: attribute, relatedBy: .Equal, toItem: self.navigationBar, attribute: attribute, multiplier: 1.0, constant: 0.0))
        }
        self.navigationBar.addConstraint(NSLayoutConstraint(item: self.progressBar, attribute: .Top, relatedBy: .Equal, toItem: self.navigationBar, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        self.progressBar.addConstraint(NSLayoutConstraint(item: self.progressBar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: self.extraHeight))
        
        self.progressBar.backgroundColor = UIColor.whiteColor()
    }
}
