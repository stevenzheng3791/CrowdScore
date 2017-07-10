//
//  SignUpViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/14/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    var ref: DatabaseReference!
    
    var baseView : BaseView!
    
    var directionsLabel : StandardLabel!
    var nextButton : StandardButton!
    
    var textField : TextField!
    var numberField : NumberField!
    var booleanField : BooleanField!
    var inputFields : [UIView]!
    
    /* Settings */
    var step = 1
    var numSteps : Int!
    var steps = [Int: (direction: String, btnDirection: String, setting: String, inputForm: UIView?, misc: [String: String])]()
    
    var firebaseClient = FirebaseClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        self.title = "Sign Up"
        
        /* load base view */
        baseView = BaseView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view = baseView
        
        
        /* load navigation buttons */
        nextButton = StandardButton(frame: CGRect(x: 0, y: 0, width: largeButtonSize.width, height: largeButtonSize.height))
        nextButton.setTitle(title: "Continue")
        nextButton.center = baseView.center
        baseView.addSubview(nextButton)
        
        
        /* load directions text */
        directionsLabel = StandardLabel(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width * 3/4, height: 0))
        directionsLabel.numberOfLines = 0
        directionsLabel.center = baseView.center
        positionViewBelow(bottomView: directionsLabel, topView: baseView.navBar, distance: 20)
        baseView.addSubview(directionsLabel)
        
        /* load input fields */
        textField = TextField(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width * 3/4, height: 50))
        textField.textAlignment = NSTextAlignment.center
        textField.backgroundColor = whiteColor
        textField.center = baseView.center
        baseView.addSubview(textField)
        
        numberField = NumberField(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width * 3/4, height: 100))
        numberField.center = baseView.center
        baseView.addSubview(numberField)
        
        booleanField = BooleanField(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width * 3/4, height: 2 * largeButtonSize.height + 20))
        booleanField.center = baseView.center
        baseView.addSubview(booleanField)
        
        inputFields = [textField,numberField,booleanField]
        
        
        /* actions */
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        baseView.navBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(prevStep))
        textField.addTarget(self, action: #selector(inputFieldDidChange(_:)), for: .editingChanged)
        numberField.number.addTarget(self, action: #selector(inputFieldDidChange(_:)), for: .editingChanged)
        
        
        /* steps details */
        steps = [1: (direction: "Enter team name", btnDirection: "Next", setting: "", inputForm: textField, misc:[:]),
                 2: (direction: "Next we will ask you a few questions to set up your team.\n\nFor the following questions, answer the best you can.\n\n(Advanced settings will be availble later)\n\n\n", btnDirection: "Next", setting: "", inputForm: nil, misc:[:]),
                 3: (direction: "How many singles matches are played per session?", btnDirection: "Next", setting: "4", inputForm: numberField, misc: ["preText": "", "postText": "Matches"]),
                 4: (direction: "How many doubles matches are played per session?", btnDirection: "Next", setting: "3", inputForm: numberField, misc: ["preText": "", "postText": "Matches"]),
                 5: (direction: "How many sets are there in a match?", btnDirection: "Next", setting: "2", inputForm: numberField, misc: ["preText": "Best of", "postText": "Sets"]),
                 6: (direction: "How many games to win a set (Win by 2)?", btnDirection: "Next", setting: "6", inputForm: numberField, misc: ["preText": "First to", "postText": "Games"]),
                 7: (direction: "Is there ad or no-ad scoring?", btnDirection: "Next", setting: "no-ad", inputForm: booleanField, misc: ["optionOne": "Ad scoring", "optionTwo": "No-ad scoring"])]

        numSteps = steps.count
        
        
        /* initiate signup process */
        step = 1
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ACTIONS */
    func inputFieldDidChange(_ textField: UITextField) {
        steps[step]?.setting = textField.text!
    }
    
    func setAdScoring() {
        steps[step]?.setting = "ad"
        nextStep()
    }
    func setNoAdScoring() {
        steps[step]?.setting = "no-ad"
        nextStep()
    }
    
    func nextStep() {
        if (step == numSteps) {
            print("Finish")
            let name = (steps[1]?.setting)!
            self.ref.child("settings").child(name).setValue(["name": name])
            
            let scoringSystem = ScoringSystem()
            //scoringSystem.matches = Int((steps[3]?.setting)!)!
            scoringSystem.sets = Int((steps[5]?.setting)!)!
            scoringSystem.games = Int((steps[6]?.setting)!)!
            scoringSystem.adScoring = ((steps[7]?.setting)! == "ad")
            firebaseClient.createTeam(name: name, password: "")
            firebaseClient.saveScoringSystem(scoringSystem: scoringSystem, singles: true)
            //saveScoringSystem(scoringSystem: scoringSystem, singles: false)

        } else {
            step += 1
            setup()
        }
    }
    
    func prevStep() {
        if (step == 1) {
            self.dismiss(animated: false, completion: nil)
        } else {
            step -= 1
            setup()
        }
    }
    
    
    func setup() {
        
        /* Set direction text */
        directionsLabel.text = steps[step]!.direction
        directionsLabel.frame.size.height = directionsLabel.sizeThatFits(CGSize(width: directionsLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
        
        let inputField = steps[step]!.inputForm
        
        if inputField == nil {
            print("no input")
            self.view.endEditing(true)
            nextButton.isHidden = false
            positionViewBelow(bottomView: nextButton, topView: directionsLabel, distance: 20)
        }
        
        
        if inputField is UITextField {
            print("text field")
            let field = inputField as! UITextField
            field.text = steps[step]?.setting
            field.becomeFirstResponder()
            nextButton.isHidden = false
            
            positionViewBelow(bottomView: inputField!, topView: directionsLabel, distance: 20)
            positionViewBelow(bottomView: nextButton, topView: inputField!, distance: 20)
        }
        
        if inputField is NumberField {
            print("num display")
            let field = inputField as! NumberField
            field.preCaption.text = steps[step]!.misc["preText"]!
            field.number.text = steps[step]?.setting
            field.caption.text = steps[step]!.misc["postText"]!
            field.number.keyboardType = .numberPad
            field.number.becomeFirstResponder()
            nextButton.isHidden = false
            
            positionViewBelow(bottomView: inputField!, topView: directionsLabel, distance: 20)
            positionViewBelow(bottomView: nextButton, topView: inputField!, distance: 20)
        }
        
        if inputField is BooleanField {
            print("boolean field")
            let field = inputField as! BooleanField
            field.optionOne.setTitle(steps[step]!.misc["optionOne"], for: .normal)
            field.optionTwo.setTitle(steps[step]!.misc["optionTwo"], for: .normal)
            nextButton.isHidden = true
            self.view.endEditing(true)

            field.optionOne.removeTarget(nil, action: nil, for: .allEvents)
            field.optionOne.addTarget(self, action: #selector(setAdScoring), for: .touchUpInside)
            
            field.optionTwo.removeTarget(nil, action: nil, for: .allEvents)
            field.optionTwo.addTarget(self, action: #selector(setNoAdScoring), for: .touchUpInside)
            
            positionViewBelow(bottomView: inputField!, topView: directionsLabel, distance: 20)
            positionViewBelow(bottomView: nextButton, topView: inputField!, distance: 20)
        }
        
        
        /* Hide non-used input fields */
        for field in inputFields {
            if field != inputField {
                field.isHidden = true
            } else {
                field.isHidden = false
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
