//
// Created by Lukas Jaklitsch on 2019-07-06.
// Copyright (c) 2019 ___Fantasy FootBall League Finder___. All rights reserved.
//
//league data is stored by team


struct League_Data {
    var id: String // Previous code
    var ppr: String //Points Per zReception
    var numTeams: String //Number of teams in the league
    var minCost: String //Minimum cost user wants to pay
    var maxCost: String //Maximum cost user wants to pay
    var numQB: String   // Number of Qb's in league
    var ScoringType: String //Head 2 Head, Points Only
    var drafType: String //Live, Autopick, Offline
    var url: String // url of the league
}


class Leagues {
    var teams = [League_Data]()

    init(){

    }

    func filter(id: String, ppr:String, numTeams:String, minCost:String, maxCost:String, numQB:String,
                user_ScoringType:String, user_draftType: String, url: String)->[League_Data]{

        //let pets = animals.filter { $0 != "chimps" }
        var returnLeague = [League_Data]()


         for team in teams {
             if (team.drafType == user_draftType && team.ScoringType == user_ScoringType && team.numQB == numQB
                 && team.minCost <= minCost && team.numTeams == numTeams && team.ppr == ppr){

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
