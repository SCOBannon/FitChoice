//
//  FitnessGoalsViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class FitnessGoalsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var goalsTable: UITableView!
    
    var goals = [String]()
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "fromGoals", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell()
        newCell.textLabel?.font = UIFont(name: "helvetica neue", size: 40.0)
        newCell.textLabel?.textAlignment = .left
        newCell.textLabel?.adjustsFontSizeToFitWidth = true
        newCell.textLabel?.text = "\(goals[indexPath.row])"
        return newCell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //        if goals[indexPath.row] == "New Goal" {
    //            goals.insert("Type Goal Here", at: indexPath.row)
    //            print(goals)
    //            goalsTable.reloadData()
    //        }
    
    //        if tableView.cellForRow(at: indexPath)?.textLabel?.text == "New Goal" {
    //            goals.insert("Type Goal Here", at: indexPath.row)
    //            print("hi")
    //        }
    
    //        if let cell = tableView.cellForRow(at: indexPath) {
    //            if let text = cell.textLabel?.text {
    //                if text == "New Goal" {
    //                    goals.insert("Type Goal Here", at: indexPath.row)
    //                    tableView.reloadData()
    //                    print(goals)
    //                }
    //            }
    //        }
    //    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func returnToGoals (sender: UIStoryboardSegue) { }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

