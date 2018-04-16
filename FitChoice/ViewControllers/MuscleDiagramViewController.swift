//
//  ViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class MuscleDiagramViewController: UIViewController {
    
    
    let mainPinkColor = UIColor(red: 195, green: 80, blue: 99, alpha: 1)
    var selectedMuscle: String?
    var facingFront = true
    var listURLs: [String: String] = [
        "Abs": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/abs/page/",
        "Arms": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/arms/page/",
        "Back": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/back/page/",
        "Butt/Hips": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/butt-hips/page/",
        "Chest": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/chest/page/",
        "Full Body/Integrated": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/full-body-integrated/page/",
        "Legs - Calves and Shins": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/legs-calves-and-shins/page/",
        "Neck": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/neck/page/",
        "Shoulders": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/shoulders/page/",
        "Legs - Thighs": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/legs-thighs/view-all"]
    
    @IBOutlet weak var absButton: UIButton!
    @IBOutlet weak var armsButton: UIButton!
    @IBOutlet weak var muscleDiagram: UIImageView!
    @IBOutlet weak var switchButton: UIButton!
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toNutrition", sender: sender)
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toGoals", sender: sender)
    }
    
    @IBAction func goToAbs(_ sender: UIButton) {
        bodyPartButtonPressed(sender)
    }
    
    @IBAction func goToArms(_ sender: UIButton) {
        bodyPartButtonPressed(sender)
    }
    
    @IBAction func `switch`(_ sender: UIButton) {
        if facingFront{
            muscleDiagram.image = #imageLiteral(resourceName: "BodyBack")
            switchButton.setImage(#imageLiteral(resourceName: "SwitchBack"), for: .normal)
            facingFront = false
        }
        else {
            muscleDiagram.image = #imageLiteral(resourceName: "BodyFront")
            switchButton.setImage(#imageLiteral(resourceName: "SwitchFront"), for: .normal)
            facingFront = true
        }
    }
    
    func bodyPartButtonPressed(_ sender: UIButton){
        selectedMuscle = sender.titleLabel?.text
        performSegue(withIdentifier: "toList", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bodyPartButtons = [absButton, armsButton]
        
        for button in bodyPartButtons {
            button?.tintColor = mainPinkColor
        }
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
                        print(url)
                        exerciseView.url = url
                    }
                }
            }
        }
    }
    
}

