//
//  ViewController.swift
//  OnboardingProgressIndicator
//
//  Created by Camille Kander on 3/18/15.
//  Copyright (c) 2015 Sproutling. All rights reserved.
//

import UIKit

let progressViewFrame = CGRectMake(20, 50, 335, 20)
let defaultNumberOfSteps = UInt(4)

class ViewController: UIViewController {

    @IBOutlet weak var numberOfStepsStepper: UIStepper!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var progressView = STOnboardingProgressView(steps: defaultNumberOfSteps, frame: progressViewFrame)

    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfStepsStepper.value = Double(defaultNumberOfSteps)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.addSubview(progressView)
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func set0(sender: UIButton) {
        self.progressView.progress = 0
    }

    @IBAction func set1(sender: UIButton) {
        self.progressView.progress = 1
    }
    
    @IBAction func set2(sender: UIButton) {
        self.progressView.progress = 2
    }
    
    @IBAction func set3(sender: UIButton) {
        self.progressView.progress = 3
    }
    
    @IBAction func set4(sender: UIButton) {
        self.progressView.progress = 4
    }
    
    @IBAction func set5(sender: UIButton) {
        self.progressView.progress = 5
    }
    
    @IBAction func updateNumberOfSteps(sender: UIStepper) {
        progressView.numberOfSteps = UInt(sender.value);
    }

}

