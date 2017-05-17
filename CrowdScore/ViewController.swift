//
//  ViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/11/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tutorialButton: UIButton!

    @IBOutlet var createTeamButton: RoundedButton!
    @IBOutlet var createTeamButtonWidth: NSLayoutConstraint!
    @IBOutlet var createTeamButtonHeight: NSLayoutConstraint!
    @IBOutlet var findTeamButton: RoundedButton!
    @IBOutlet var findTeamButtonHeight: NSLayoutConstraint!
    @IBOutlet var findTeamButtonWidth: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createTeamButton.backgroundColor = blueButtonColor
        createTeamButton.setTitleColor(whiteColor, for: .normal)
        createTeamButton.setTitle("Create New Team", for: .normal)
        createTeamButtonWidth.constant = largeButtonSize.width
        createTeamButtonHeight.constant = largeButtonSize.height
        createTeamButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        
        createTeamButton.addTarget(self, action:#selector(goToSignup), for: .touchUpInside)
        findTeamButton.backgroundColor = blueButtonColor
        findTeamButton.setTitleColor(whiteColor, for: .normal)
        findTeamButton.setTitle("Find a Team", for: .normal)
        findTeamButtonWidth.constant = largeButtonSize.width
        findTeamButtonHeight.constant = largeButtonSize.height
        findTeamButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        
        
        tutorialButton.setTitle("How It Works", for: .normal)
        tutorialButton.setTitleColor(whiteColor, for: .normal)
    }

    func goToSignup() {
        let vc = SignUpViewController()
        self.present(vc, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

