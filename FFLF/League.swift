//
//  League_Data.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/18/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation

class League{
    var id: String // Previous code
    var ppr: Double //Points Per zReception
    var numTeams: Int //Number of teams in the league
    var minCost: Int //Minimum cost user wants to pay
    var maxCost: Int //Maximum cost user wants to pay
    var numQB: Int    // Number of Qb's in league
    var ScoringType: String //Head 2 Head, Points Only
    var drafType: String //Live, Autopick, Offline
    var url: String // url of the league
    
    init(id: String, ppr:Double, numTeams:Int, minCost:Int, maxCost:Int, numQB:Int, ScoringType:String, drafType: String, url: String) {
        self.id = id
        self.ppr = ppr
        self.numTeams = numTeams
        self.minCost = minCost
        self.maxCost = maxCost
        self.numQB = numQB
        
        self.drafType = drafType
        self.ScoringType = ScoringType
        self.url = url
    }
    
    
    //Test Print
    func print(){
        Swift.print(ppr);
    }
}
//now that data is being stored in an array
//now peeople turn to easy searching, its like when people use cook books, theyre looking for something specific,

//how to do the costs and dates?????
//Write a method that returns the cost in the right range and
