//
//  ExerciseInfoViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 3/14/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class ExerciseInfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var stepsView: UITextView!
    
    var exerciseURL: String?
    var scraper: ExerciseScraper?
    var muscle: String?
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toListFromInfo", sender: sender)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toListFromInfo", sender: sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let url = exerciseURL {
            scraper = ExerciseScraper(exerciseURL: url, view: self)
        }
        
        infoLabel.adjustsFontSizeToFitWidth = true
        stepsView.isEditable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromInfo" {
            if let exerciseListView = segue.destination as? ExerciseListViewController {
                if let selectedMuscle = muscle {
                    exerciseListView.selectedMuscle = selectedMuscle
                }
            }
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
