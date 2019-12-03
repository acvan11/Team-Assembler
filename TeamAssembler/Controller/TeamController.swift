//
//  TeamController.swift
//  TeamAssembler
//
//  Created by K Y on 11/26/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import Foundation

protocol TeamControllerProtocol {
    var team: [Teammate] { get }
    var teamSize: Int { get }
    func getTeam()
    func newTeammate(name: String, might: String)
    func deleteTeammate(at index: Int)
}

protocol TeamControllerViewProtocol {
    func didAddTeammate()
    func didDeleteTeammate(at index: Int)
    func didRefreshTeam()
}

class TeamController: TeamControllerProtocol {
    let realm = RealmAdapter()
    var team: [Teammate]
    var view: TeamControllerViewProtocol
    
    var teamSize: Int {
        return team.count
    }
    
    init(_ view: TeamControllerViewProtocol) {
        team = [Teammate]()
        self.view = view
    }
    
    func getTeam() {
        team = realm.fetchObjects(Teammate.self)
        view.didRefreshTeam()
    }
    
    func newTeammate(name: String, might: String) {
        let newTeammate = Teammate(name: name, might: might)
        team.append(newTeammate)
        realm.add(newTeammate)
        view.didAddTeammate()
    }
    
    func deleteTeammate(at index: Int) {
        let removed = team.remove(at: index)
        realm.delete(removed)
        if team.isEmpty {
            view.didRefreshTeam()
        }
        else {
            view.didDeleteTeammate(at: index)
        }
    }
}
