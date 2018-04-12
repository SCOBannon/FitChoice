//
//  ViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class MuscleDiagramViewController: UIViewController {
    
    var selectedMuscle: String?
    var listURLs: [String: String] = ["Abs": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/abs/page/"]
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toNutrition", sender: sender)
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toGoals", sender: sender)
    }
    
    @IBAction func absButton(_ sender: UIButton) {
        selectedMuscle = sender.titleLabel?.text
        performSegue(withIdentifier: "toList", sender: sender)
    }
    
    @IBAction func bicepsButton(_ sender: UIButton) {
        selectedMuscle = sender.titleLabel?.text
        performSegue(withIdentifier: "toList", sender: sender)
    }
    
    //@IBAction func unwindToDiagram(segue: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            if let exerciseView = segue.destination as? ExerciseListViewController {
                if let muscle = selectedMuscle {
                    exerciseView.selectedMuscle = muscle
                    if let url = listURLs[muscle] {
                        exerciseView.url = url
                    }
                }
            }
        }
    }
    
}

