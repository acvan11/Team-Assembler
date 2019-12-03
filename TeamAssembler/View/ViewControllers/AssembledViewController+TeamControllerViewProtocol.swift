//
//  AssembledViewController+TeamControllerViewProtocol.swift
//  TeamAssembler
//
//  Created by K Y on 11/26/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit

extension AssembledViewController: TeamControllerViewProtocol {
    func didAddTeammate() {
        let currState = tableView.currentState
        switch currState {
            case .loaded:
                let p = IndexPath(row: controller.teamSize - 1, section: 0)
                tableView.insertRows(at: [p], with: .automatic)
            case .error:
                print("Error state, cannot present.")
            default:
                tableView.currentState = .loaded
        }
    }

    func didRefreshTeam() {
        if controller.teamSize == 0 {
            tableView.currentState = .empty
        }
        else {
            tableView.currentState = .loaded
        }
    }
    
    func didDeleteTeammate(at index: Int) {
        let currState = tableView.currentState
        switch currState {
            case .loaded:
                let p = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [p], with: .automatic)
            case .error:
                print("Error state, cannot present.")
            default:
                tableView.currentState = .loaded
        }
    }
}
