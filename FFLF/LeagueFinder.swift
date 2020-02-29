//
//  LeagueFinder.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/15/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class LeagueFinder: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
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
    
    
    //For tableview
    //returns hoe many cells will be in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.teams.count
    }
    
    //for tablesview
    //stores in each cell the array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        //cell.textLabel?.text = namesArray.teams[indexPath.row].url + " Date: " + namesArray.teams[indexPath.row].date
        
        return cell
    }
    
    let draftChoices = ["Live", "Offline", "Autopick"]
    let scoringChoices = ["H2H", "Points"]
    
    //Declared outside to be referenced anywhere
    var ref:DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.scoringPicker.isHidden = true
        self.draftPicker.isHidden = true
        
        ref = Database.database().reference().child("Leagues_New3")
    }
    
    
    @IBAction func Home(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Home", sender: self)
    }
   
    //What type of league?
    //Inputs from user
    @IBOutlet weak var numTeams: UITextField!
    @IBOutlet weak var ppr: UITextField!
    @IBOutlet weak var minCost: UITextField!
    @IBOutlet weak var maxCost: UITextField!
    @IBOutlet weak var numQb: UITextField!
    @IBOutlet weak var scoringType: UITextField!
    @IBOutlet weak var draftType: UITextField!
    
    //declared outside to be accessed by tableView
    var testArray = Leagues()
    var namesArray = Leagues()
    //var testArray = [League]()
    
    @IBOutlet weak var draftPicker: UIPickerView!
    @IBOutlet weak var scoringPicker: UIPickerView!
    
    //Pulls results into an array that is linked to tableview
    //and prints to tableview.
    //Matches a key to leagues that fit the criteria that is input by the user
    //
    func getResults(){
        testArray.reset()
        namesArray.reset()

        //store user input in variables
        let ppr = self.ppr.text!
        let numTeams = self.numTeams.text!
        let user_minCost = self.minCost.text!
        let user_maxCost = self.maxCost.text!
        let numQb = self.numQb.text!
        let scoringType = self.scoringType.text!
        let draftType = self.draftType.text!
        
        //key that matches input with database(fireflame)
        //let key = numTeams + ppr + numQb
        
        
        //pulls from firebase the matching id == to key (above)
        ref?.queryOrdered(byChild: "teams").queryEqual(toValue: NSString(utf8String:String(numTeams))).observe(.value, with:
            { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let userDict = snap.value as! [String: AnyObject]
                
                let url = userDict["url"] as! String
                let ppr = userDict["ppr"] as! String
                let fire_minCost = userDict["minCost"] as! String // should always be zero
                let fire_maxCost = userDict["cost"] as! String //should be cost val
                let scoringType = userDict["leagueType"] as! String
                //let draftType = userDict["draftType"] as! String
                //let draftDate = userDict["Draft Date"] as! String

                
                //let url = results?["url"]
                
                //create new league by pulling out of the database
                let league = League_Data(ppr:ppr, numTeams:numTeams, minCost:fire_minCost, maxCost:fire_maxCost, numQB:numQb, scoringType: scoringType, drafType: "Live", url: url)

                //add matching value to array, the url
                self.testArray.teams.append(league)

                //print(self.testArray.teams[0])
                //print("SNAP: ", snap.key)
                //print("SNAPSHOT: ", snapshot.value!)
                
            }
                //print("Max: ", user_maxCost)
                //print("Min: ", user_minCost)
                
                //Filter the results
                //Test against user input results
                self.namesArray.teams = self.testArray.filter(ppr:ppr, numTeams:numTeams, user_minCost:user_minCost, user_maxCost:user_maxCost, numQB:numQb, scoringType:scoringType, draftType: draftType)
                
                //print(self.testArray.teams[0])
                //After the array is filled with matching values
                //reload data to display to the table view
                print(self.namesArray.teams.count)
                self.display.reloadData()
        })
}
    
    
    //TableView outlet
    @IBOutlet weak var display: UITableView!
    
    //Seach Button to get results
    @IBAction func search(_ sender: UIButton) {
        getResults()
    }
}

/*
 print("SNAPSHOT: ",snapshot.childrenCount)
 print("SNAPSHOT: ",snapshot)
 print("Snapshot Value:", snapshot.value!)
 print("Snapshot Value:", snapshot.children)
 //print("key = \(key)  value = \(value!)")
 //print(self.namesArray.count)
 // let key = snap.key
 //let value = snap.value
 //print("Results: ", results!)
 */
