//
//  ViewController.swift
//  OnboardingProgressIndicator
//
//  Created by Camille Kander on 3/18/15.
//  Copyright (c) 2015 Sproutling. All rights reserved.
//

import UIKit

let kKeyPathNumberOfSteps = "numberOfSteps"
let kKeyPathProgress = "progress"

class ViewController: UIViewController {

    @IBOutlet weak var progressView: STOnboardingProgressView!
    @IBOutlet weak var numberOfStepsStepper: UIStepper!
    @IBOutlet weak var progressStepper: UIStepper!
    @IBOutlet weak var numberOfStepsLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    private var myContext = 0
    
    required init(coder aDecoder: NSCoder) {
        STOnboardingProgressView.appearance().tintColor = kColourComplete
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfStepsStepper.value = Double(progressView.numberOfSteps)
        progressView.addObserver(self, forKeyPath: kKeyPathNumberOfSteps, options: .New, context: &myContext)
        progressView.addObserver(self, forKeyPath: kKeyPathProgress, options: .New, context: &myContext)
    }
    
    deinit {
        progressView.removeObserver(self, forKeyPath: kKeyPathNumberOfSteps)
        progressView.removeObserver(self, forKeyPath: kKeyPathProgress)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.addSubview(progressView)
        numberOfStepsLabel.text = "Number of steps: \(UInt(numberOfStepsStepper.value))"
        progressLabel.text = "Progress: \(UInt(progressStepper.value))"
        
        let programmaticProgressView = STOnboardingProgressView(steps: 4, frame: CGRectMake(20, 300, 200, 18))
        view.addSubview(programmaticProgressView)
        
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if (context == &myContext) {
            switch keyPath {
            case kKeyPathNumberOfSteps:
                numberOfStepsStepper.value = change[NSKeyValueChangeNewKey] as Double
                numberOfStepsLabel.text = "Number of steps: \(UInt(numberOfStepsStepper.value))"
            case kKeyPathProgress:
                progressStepper.value = change[NSKeyValueChangeNewKey] as Double
                progressLabel.text = "Progress: \(UInt(progressStepper.value))"
            default:
                ()
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    @IBAction func updateNumberOfSteps(sender: UIStepper) {
        progressView.numberOfSteps = UInt(sender.value);
    }

    @IBAction func updateProgress(sender: UIStepper) {
        progressView.progress = UInt(sender.value);
    }
}

