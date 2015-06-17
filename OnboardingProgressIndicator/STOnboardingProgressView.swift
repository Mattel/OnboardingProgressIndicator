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
    private var stepViewConstraints = NSMutableSet()
    
    dynamic var numberOfSteps: UInt {
        didSet {
            progress = min(progress, numberOfSteps)
            setupStepViews()
        }
    }
    
    dynamic var progress: UInt = 0 {
        didSet {
            if (progress > numberOfSteps) {
                progress = numberOfSteps
            }
            
            for view in self.stepViews {
                let index = find(stepViews, view)!
                configureColourForStepView(view, index: index)
            }
        }
    }
    
    override init(frame: CGRect) {
        numberOfSteps = kDefaultNumberOfSteps
        super.init(frame: frame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setNeedsUpdateConstraints", name: UIDeviceOrientationDidChangeNotification, object: nil)
        setupStepViews()
    }
    
    convenience init(steps: UInt, frame: CGRect) {
        self.init(frame: frame)
        numberOfSteps = steps
        setupStepViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        numberOfSteps = kDefaultNumberOfSteps
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setNeedsUpdateConstraints", name: UIDeviceOrientationDidChangeNotification, object: nil)
        setupStepViews()
    }
    
    override func updateConstraints() {
        
        if (isEmpty(stepViews)) {
            super.updateConstraints()
            return
        }
        
        if (self.frame.size.width == 0.0) {
            super.updateConstraints()
            return
        }
            
        superview!.layoutIfNeeded()
        layoutIfNeeded()
        let width = (frame.width - (kSeparatorWidth * CGFloat(numberOfSteps - 1))) / CGFloat(numberOfSteps)
        
        let currentConstraints = constraints() as! [NSLayoutConstraint]
        for constraint in currentConstraints {
            if (stepViewConstraints.containsObject(constraint)) {
                removeConstraint(constraint)
            }
        }
        
        for view in stepViews {
            view.removeConstraints(view.constraints())
            
            self.addSubview(view)
            
            let index = find(stepViews, view)!
            configureColourForStepView(view, index: index)
            
            var leftConstraint: NSLayoutConstraint
            if (index != 0) {
                leftConstraint = NSLayoutConstraint(item: stepViews[index-1], attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: -1 * kSeparatorWidth)
            } else {
                leftConstraint = NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
            }
            
            let topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0.0)
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: frame.height)
            
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
            let newConstraints = [leftConstraint, topConstraint, widthConstraint, heightConstraint]
            self.addConstraints(newConstraints)
            stepViewConstraints.addObjectsFromArray(newConstraints)
        }
        
        super.updateConstraints()
    }
    
    private func setupStepViews() {
        
        for oldView in stepViews {
            oldView.removeFromSuperview()
        }
        
        stepViews = []
        
        for var i = UInt(0); i < numberOfSteps; i++ {
            stepViews.append(UIView())
        }
        
        setNeedsUpdateConstraints()
    }
    
    private func configureColourForStepView(view :UIView, index: Int) {
        if (index < Int(progress)) {
            view.backgroundColor = tintColor
        } else {
            view.backgroundColor = kColourIncomplete
        }
    }
}
