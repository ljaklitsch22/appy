//
//  ViewController.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/12/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    @IBAction func OwnerPost(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToOwnerPost", sender: self)
    }

    @IBAction func LeagueFinder(_ sender: UIButton) {
    self.performSegue(withIdentifier: "LeagueFinder", sender: self)
    }
    
    @IBAction func SavedLeagues(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToSavedLeagues", sender: self)
    }
}
