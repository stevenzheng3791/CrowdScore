//
//  ViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/11/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    var logo: UIImageView!
    var slogan: StandardLabel!
    var createTeamButton: StandardButton!
    var findTeamButton: StandardButton!
    var tutorialButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Initial"
        
        let baseView = BaseView(frame: self.view.frame)
        baseView.navBar.isHidden = true
        self.view.addSubview(baseView)
        
        logo = UIImageView(frame: CGRect(center: CGPoint(x: self.view.center.x, y: 200), size: CGSize(width: 238, height: 146)))
        logo.image = UIImage(named: "Logo")
        
        baseView.addSubview(logo)
        
        
        createTeamButton = StandardButton(frame: CGRect(origin: CGPoint(), size: largeButtonSize))
        createTeamButton.center.x = baseView.center.x
        createTeamButton.frame.origin.y = getYOrigin(topView: logo, distance: 40)
        createTeamButton.setTitle(title: "Create New Team")
        createTeamButton.addTarget(self, action:#selector(goToSignup), for: .touchUpInside)
        baseView.addSubview(createTeamButton)
        
        findTeamButton = StandardButton(frame: CGRect(origin: CGPoint(), size: largeButtonSize))
        findTeamButton.center.x = baseView.center.x
        findTeamButton.frame.origin.y = getYOrigin(topView: createTeamButton, distance: 40)
        findTeamButton.setTitle(title: "Find New Team")
        baseView.addSubview(findTeamButton)
        
        
        tutorialButton = UIButton(frame: CGRect(origin: CGPoint(), size: largeButtonSize))
        tutorialButton.center.x = baseView.center.x
        tutorialButton.frame.origin.y = getYOrigin(topView: findTeamButton, distance: 40)
        tutorialButton.setTitleColor(whiteColor, for: .normal)
        baseView.addSubview(tutorialButton)
        
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

