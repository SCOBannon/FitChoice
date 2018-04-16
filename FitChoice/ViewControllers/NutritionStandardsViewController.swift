//
//  NutritionStandardsViewController.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 2/22/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class NutritionStandardsViewController: UIViewController {

    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "fromNutrition", sender: sender)
    }
    
    
//    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
//        performSegue(withIdentifier: "fromNutrition", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
