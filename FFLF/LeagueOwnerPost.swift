//
//  LeagueOwnerPost.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/15/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class LeagueOwnerPost: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == draftPicker){
            return self.draftChoices.count
        }else{
            return self.scoringChoices.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == draftPicker {
            self.view.endEditing(true)
            return draftChoices[row]
            
        }else if pickerView == scoringPicker{
            self.view.endEditing(true)
            return scoringChoices[row]

        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == draftPicker){
            self.draftType.text = self.draftChoices[row]
            self.draftPicker.isHidden = true
            
        } else if (pickerView == scoringPicker) {
            self.scoringType.text = self.scoringChoices[row]
            self.scoringPicker.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == self.draftType){
            self.draftPicker.isHidden = false
        }
        if (textField == self.scoringType){
            self.scoringPicker.isHidden = false
        }
    }
    
    
    @IBAction func dateTextBox(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(LeagueOwnerPost.datePickerValChange), for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValChange(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.medium
        
        draftDate.text = dateFormatter.string(from: sender.date)
    }
    
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoringPicker.isHidden = true
        self.draftPicker.isHidden = true
        self.draftDate.text = "Select Date"
        ref = Database.database().reference()
        
        //datePicker.datePickerMode = .date
        //draftDate.inputView = datePicker
    }
    
    //Home Segue
    @IBAction func Home(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Home", sender: self)
    }
    
    //user input variables
    let draftChoices = ["Live", "Offline", "Autopick"]
    let scoringChoices = ["H2H", "Points"]
    
    @IBOutlet weak var ppr: UITextField!
    @IBOutlet weak var numTeams: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var numQB: UITextField!
    @IBOutlet weak var scoringType: UITextField! //add these in
    @IBOutlet weak var draftType: UITextField!  /////////
    @IBOutlet weak var URL: UITextField!
    @IBOutlet weak var draftDate: UITextField!
    
    
    @IBOutlet weak var draftPicker: UIPickerView!
    @IBOutlet weak var scoringPicker: UIPickerView!
    
    
    
     //post button
     @IBAction func Post(_ sender: UIButton) {
        
        let url = URL.text!
        
        let league = ["teams": numTeams.text! as String, "ppr": ppr.text! as String, "cost": cost.text! as String, "numQb": numQB.text! as String, "draftType": draftType.text! as String, "scoringType": scoringType.text! as String, "url": url, "minCost": "0"]
        
        ref?.child("Leagues_New3").childByAutoId().setValue(league)
        
        //TODO: ADD "LEAGUE ADDED"
     
     self.performSegue(withIdentifier: "Home", sender: self)
     }
}


/*
 let teams = Int(TeamVal.text!)
 let ppr = Double(ppr_text.text!)
 let max_cost = Int(max_cost_text.text!)
 let two_qb = Int(two_qb_text.text!)
 
 let league2 = League(ppr:ppr!,teams:teams!,min_cost: 0, max_cost:max_cost!, two_qb:two_qb!)
 league.print()
 */
