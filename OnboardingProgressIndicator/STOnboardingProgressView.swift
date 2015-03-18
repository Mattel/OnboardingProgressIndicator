//
//  STOnboardingProgressView.swift
//  OnboardingProgressIndicator
//
//  Created by Camille Kander on 3/18/15.
//  Copyright (c) 2015 Sproutling. All rights reserved.
//

import UIKit

let kColorComplete      = UIColor(red: 0xF3/0xFF, green: 0xAB/0xFF, blue: 0x36/0xFF, alpha: 1.0) // #F3AB36
let kColorIncomplete    = UIColor(white: 0xE3/0xFF, alpha: 1.0) // #E3E3E3
let kSeparatorWidth     = CGFloat(2.0)

class STOnboardingProgressView: UIView {
    
    let numberOfSteps: UInt = 5
    var progress: UInt = 0 {
        didSet {
            if (progress > numberOfSteps) {
                progress = numberOfSteps
            }
            
            for view in self.stepViews {
                let index = find(stepViews, view)
                if (index < Int(progress)) {
                    view.backgroundColor = kColorComplete
                } else {
                    view.backgroundColor = kColorIncomplete
                }
            }
        }
    }
    private var stepViews: [UIView]
    
    override init(frame: CGRect) {
        
        // create the subviews
        stepViews = []
        for var i = UInt(0); i < numberOfSteps; i++ {
            stepViews.append(UIView());
        }
                
        super.init(frame: frame)
        
        // set the frames for the subviews
        for view in stepViews {
            let index = find(stepViews, view)!
            let width = (frame.width - (kSeparatorWidth * CGFloat(numberOfSteps - 1))) / CGFloat(numberOfSteps)
            let x = (width + kSeparatorWidth) * CGFloat(index)
            view.frame = CGRectMake(x, 0, width, frame.size.height)
            view.backgroundColor = kColorIncomplete
            self.addSubview(view)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
