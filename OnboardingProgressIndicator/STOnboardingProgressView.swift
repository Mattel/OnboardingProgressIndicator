//
//  STOnboardingProgressView.swift
//  OnboardingProgressIndicator
//
//  Created by Camille Kander on 3/18/15.
//  Copyright (c) 2015 Sproutling. All rights reserved.
//

import UIKit

let kColourComplete         = UIColor(red: 0xF3/0xFF, green: 0xAB/0xFF, blue: 0x36/0xFF, alpha: 1.0) // #F3AB36
let kColourIncomplete       = UIColor(white: 0xE3/0xFF, alpha: 1.0) // #E3E3E3
let kSeparatorWidth         = CGFloat(2.0)
let kDefaultNumberOfSteps   = UInt(5)

class STOnboardingProgressView: UIView {
    
    private var stepViews: [UIView]! = []
    var numberOfSteps: UInt {
        didSet {
            progress = 0
            setupStepViews()
            setNeedsUpdateConstraints()
        }
    }
    
    var progress: UInt = 0 {
        didSet {
            if (progress > numberOfSteps) {
                progress = numberOfSteps
            }
            
            for view in self.stepViews {
                let index = find(stepViews, view)
                if (index < Int(progress)) {
                    view.backgroundColor = kColourComplete
                } else {
                    view.backgroundColor = kColourIncomplete
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        numberOfSteps = kDefaultNumberOfSteps
        super.init(frame: frame)
        setupStepViews()
    }
    
    convenience init(steps: UInt, frame: CGRect) {
        
        self.init(frame: frame)
        numberOfSteps = steps
        setupStepViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        for view in stepViews {
            
            self.addSubview(view)
            view.backgroundColor = kColourIncomplete
            
            let index = UInt(find(stepViews, view)!)
            
            var leftConstraint: NSLayoutConstraint
            if (index != 0) {
                leftConstraint = NSLayoutConstraint(item: stepViews[index-1], attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: -1 * kSeparatorWidth)
            } else {
                leftConstraint = NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            }
            
            let topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0.0)
            
            let width = (frame.width - (kSeparatorWidth * CGFloat(numberOfSteps - 1))) / CGFloat(numberOfSteps)
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
            
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: frame.height)
            
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addConstraints([leftConstraint, topConstraint, widthConstraint, heightConstraint])
        }
    }
    
    private func setupStepViews() {
        
        for oldView in stepViews {
            oldView.removeFromSuperview()
        }
        
        stepViews = []
        
        for var i = UInt(0); i < numberOfSteps; i++ {
            stepViews.append(UIView())
        }
    }
}
