//
//  League_List.swift
//  Fantasy Football League Finder
//
//  Created by Lukas Jaklitsch on 6/19/19.
//  Copyright © 2019 Lukas Jaklitsch. All rights reserved.
//

import Foundation

struct League_Data {
    var ppr: String //Points Per zReception
    var numTeams: String //Number of teams in the league
    var minCost: String //Minimum cost user wants to pay
    var maxCost: String //Maximum cost user wants to pay
    var numQB: String   // Number of Qb's in league
    var scoringType: String //Head 2 Head, Points Only
    var drafType: String //Live, Autopick, Offline
    var url: String // url of the league
}


class Leagues {
    var teams = [League_Data]()
    
    init(){
        
    }
    
    func reset(){
        teams = [League_Data]()
    }
    
    //Parameters are to test self.fields against
    func filter(ppr:String, numTeams:String, user_minCost:String, user_maxCost:String, numQB:String, scoringType:String, draftType: String)->[League_Data]{
        
        var returnLeague = [League_Data]()
        
        for team in self.teams {
            if (team.drafType == draftType && team.scoringType ==  scoringType && team.numQB == numQB && Int(team.maxCost) ?? 0 >= Int(user_minCost) ?? 0 && Int(team.maxCost) ?? 0 <= Int(user_maxCost) ?? 0 && team.numTeams == numTeams && team.ppr == ppr){
                
                
                print("User Max: ", user_maxCost)
                print("Team Max: ", team.maxCost)
                print("User Min: ", user_minCost)
                print("Team Min: ", team.minCost)

                
                returnLeague.append(team)
            }
        }
        
        return returnLeague;
    }
    
    
    // Removes league from the list
    /*func removeLeague(){
     if let index = teams.index(of:"beta") {
     teams.remove(at: index)
     }
     }
     */
    
    func addLeague(newLeague:League_Data){
        teams.append(newLeague)
    }
    
}
