//
//  GoalInputViewController.swift
//  FitChoice
//
//  Created by Sean O'Bannon (student LM) on 4/18/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class GoalInputViewController: UIViewController {

    @IBOutlet weak var goalText: UITextView!
    
    @IBAction func saveInput(_ sender: UIButton) {
        performSegue(withIdentifier: "toGoalsFromInput", sender: sender)
    }
    
    @IBAction func cancelInput(_ sender: UIButton) {
        performSegue(withIdentifier: "toGoalsFromInput", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoalsFromInput" {
            if let goalView = segue.destination as? FitnessGoalsViewController {
                if let button = sender as? UIButton {
                    if let label = button.titleLabel {
                        if let text = label.text {
                            if text == "Save" {
                                goalView.goals.append(goalText.text)
                            }
                        }
                    }
                }
                if goalView.goals.count == 0 {
                    goalView.goals.append("No Current Goals")
                } else if goalView.goals.count > 1 {
                    if goalView.goals[0] == "No Current Goals" {
                        goalView.goals.remove(at: 0)
                    }
                }
                goalView.goalsTable.reloadData()
            }
        }
        goalText.text = "Enter Goal Here"
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
