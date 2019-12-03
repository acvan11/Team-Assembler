//
//  AssembledViewController.swift
//  TeamAssembler
//
//  Created by K Y on 11/26/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import UIKit
import StateUITableView

private let MAKE_TEAMMATE_SEGUE_ID = "makeTeammate"
private let TEAM_CELL_REUSE_ID = "teamCellID"

class AssembledViewController: UIViewController {

    // MARK: - Storyboard Outlets
    
    @IBOutlet var tableView: StateTableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.stateDelegate = self
            tableView.errorDelegate = self
            let nib = UINib(nibName: "TeammateTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: TEAM_CELL_REUSE_ID)
        }
    }
    
    // MARK: - Properties
    
    lazy var controller: TeamControllerProtocol = {
        return TeamController(self)
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.currentState = .empty
        controller.getTeam()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MAKE_TEAMMATE_SEGUE_ID, let vc = segue.destination as? MakeTeammateViewController {
            vc.delegate = self
        }
    }
    
    // MARK: - Custom Action Method
    
    @IBAction func makeAction(_ sender: Any) {
        performSegue(withIdentifier: MAKE_TEAMMATE_SEGUE_ID, sender: nil)
    }
    

}

extension AssembledViewController: StateTableViewProtocol {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.teamSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TEAM_CELL_REUSE_ID,
                                                 for: indexPath) as! TeammateTableViewCell
        
        let m = controller.team[indexPath.row]
        cell.nameLabel.text = m.name
        cell.mightLabel.text = m.might
        
        return cell
    }
}

extension AssembledViewController: UITableViewDelegate {
    #if compiler(>=5)
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "DELETE")
        { (action, view, completion) in
            self.controller.deleteTeammate(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    #endif
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "DELETE!")
        { (action, indexPath) in
            self.controller.deleteTeammate(at: indexPath.row)
        }
        
        return [action]
    }
}

extension AssembledViewController: StateTableViewErrorProtocol {
    
    func errorMessage(forStateTableRect rect: CGRect) -> UIView! {
        let label = UILabel(frame: .zero)
        label.text = "There was an error loading your TEAM!"
        label.textAlignment = .center
        return label
    }
    
    func emptyMessage(forStateTableRect rect: CGRect) -> UIView! {
        let label = UILabel(frame: .zero)
        label.text = "You have no team!\nTime to ASSSEEMMMBBBLLLEEEEEEEEE!"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }
}

extension AssembledViewController: SendTeammateDataDelegate {
    func send(name: String, might: String) {
        controller.newTeammate(name: name, might: might)
    }
}
