//
//  ViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class MuscleDiagramViewController: UIViewController {
    
    let mainPinkColor = UIColor(red: 195/255, green: 80/255, blue: 99/255, alpha: 1)
    var selectedMuscle: String?
    var facingFront = true
    var listURLs: [String: String] = [
        "Abs": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/abs/page/",
        "Arms": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/arms/page/",
        "Back": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/back/page/",
        "Butt/Hips": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/butt-hips/page/",
        "Chest": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/chest/page/",
        "Full Body/Integrated": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/full-body-integrated/page/",
        "Calves and Shins": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/legs-calves-and-shins/page/",
        "Neck": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/neck/page/",
        "Shoulders": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/shoulders/page/",
        "Thighs": "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/legs-thighs/view-all"]
    
    var frontButtons: [UIButton] = []
    var backButtons: [UIButton] = []
    
    @IBOutlet weak var absButton: UIButton!
    @IBOutlet weak var armsButton: UIButton!
    @IBOutlet weak var neckButton: UIButton!
    @IBOutlet weak var chestButton: UIButton!
    @IBOutlet weak var thighsButton: UIButton!
    @IBOutlet weak var calvesAndShinsButton: UIButton!
    @IBOutlet weak var neckBackButton: UIButton!
    @IBOutlet weak var armsBackButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var thighsBackButton: UIButton!
    @IBOutlet weak var calvesAndShinsBackButton: UIButton!
    @IBOutlet weak var muscleDiagram: UIImageView!
    @IBOutlet weak var switchButton: UIButton!
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toNutrition", sender: sender)
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "toGoals", sender: sender)
    }
    
    @IBAction func goToExerciseList(_ sender: UIButton) {
        selectedMuscle = sender.titleLabel?.text
        performSegue(withIdentifier: "toList", sender: sender)
    }
    
    
    @IBAction func `switch`(_ sender: UIButton) {
        if facingFront{
            muscleDiagram.image = #imageLiteral(resourceName: "BodyBack")
            switchButton.setImage(#imageLiteral(resourceName: "SwitchBack"), for: .normal)
            
            for button in frontButtons {
                button.alpha = 0
            }
            
            for button in backButtons {
                button.alpha = 1
            }
            
            facingFront = false
        }
        else {
            muscleDiagram.image = #imageLiteral(resourceName: "BodyFront")
            switchButton.setImage(#imageLiteral(resourceName: "SwitchFront"), for: .normal)
            
            for button in frontButtons {
                button.alpha = 1
            }
            
            for button in backButtons {
                button.alpha = 0
            }
            
            facingFront = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontButtons = [absButton, armsButton, neckButton, chestButton, thighsButton, calvesAndShinsButton]
        
        backButtons = [neckBackButton, armsBackButton, backButton, thighsBackButton, calvesAndShinsBackButton]
        
        for button in frontButtons {
            button.setTitleColor(mainPinkColor, for: .normal)
        }
        
        for button in backButtons {
            button.setTitleColor(mainPinkColor, for: .normal)
            button.alpha = 0
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

