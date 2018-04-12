//
//  Goals.swift
//  FitChoice
//
//  Created by Sean O'Bannon (student LM) on 3/19/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class GoalsTableViewData: NSObject, UITableViewDataSource {
    
    var goals: [String]
    
    override init() {
        goals = ["New Goal"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell()
        newCell.textLabel?.font = UIFont(name: "helvetica neue", size: 40.0)
        newCell.textLabel?.textAlignment = .left
        if goals[indexPath.row] != "New Goal" {
            newCell.isEditing = true
        }
        newCell.textLabel?.text = "\(goals[indexPath.row])"
        return newCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let newCell = UITableViewCell()
//        newCell.textLabel?.font = UIFont(name: "helvetica neue", size: 40.0)
//        newCell.textLabel?.textAlignment = .left
//        newCell.textLabel?.text = "\(goals[indexPath.row])"
//    }
    
}
