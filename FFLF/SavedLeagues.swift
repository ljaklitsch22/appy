//
//  SavedLeagues.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/17/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation
import UIKit

class SavedLeagues: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
}

    @IBAction func Home(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Home", sender: self)
    }
}
