//
//  FitnessGoalsViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class FitnessGoalsViewController: UIViewController {

    var freshLaunch = true
    @IBOutlet weak var goalsTable: UITableView!
    @IBOutlet var goalsData: GoalsTableViewData!
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "fromGoals", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if let text = cell.textLabel?.text {
                if text == "New Goal" {
                    if let data = tableView.dataSource as? GoalsTableViewData {
                        data.goals.insert("Type Goal Here", at: indexPath.row)
                    }
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if freshLaunch == true {
            freshLaunch = false
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
