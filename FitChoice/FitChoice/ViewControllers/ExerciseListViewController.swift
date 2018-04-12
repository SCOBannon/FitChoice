//
//  ExerciseListViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 3/6/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class ExerciseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMuscle: String = "Abs"
    var url: String = "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/abs/page/"
    var scraper: ListScraper?
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var listTable: UITableView!
    
    @IBAction func downSwipe(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
      //performSegue(withIdentifier: "toDiagram", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let listScraper = scraper {
            if let sortedNames = listScraper.sortedExercises {
                performSegue(withIdentifier: "toInfo", sender: listScraper.exercises[sortedNames[indexPath.row]])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfo" {
            if let exerciseInfo = segue.destination as? ExerciseInfoViewController {
                if let url = sender as? String {
                    exerciseInfo.exerciseURL = url
                    exerciseInfo.muscle = selectedMuscle
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exerciseLabel.text = selectedMuscle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scraper = ListScraper.init(listURL: url, tableView: listTable)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let listScraper = scraper {
            return listScraper.exercises.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell()
        newCell.textLabel?.font = UIFont(name: "helvetica neue", size: 20.0)
        newCell.textLabel?.textAlignment = .left
        newCell.textLabel?.adjustsFontSizeToFitWidth = true
        if let listScraper = scraper {
            if let sortedNames = listScraper.sortedExercises {
                newCell.textLabel?.text = "\(sortedNames[indexPath.row])"
            }
        } else {
            newCell.textLabel?.text = "Missing Exercise"
        }
        return newCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func returnToList (sender: UIStoryboardSegue) { }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
