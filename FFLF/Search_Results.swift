//
//  Search_Results.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/22/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation
import UIKit

class Search_Results: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let list = ["milk", "eggs", "honey"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    }
