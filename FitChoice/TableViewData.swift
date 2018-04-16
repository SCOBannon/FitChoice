//
//  TableViewData.swift
//  fitchoiceproto
//
//  Created by Sean O'Bannon (student LM) on 3/8/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class TableViewData: NSObject, UITableViewDataSource {
    
    var exerciseList: ExerciseList
    
    override init() {
        exerciseList = ExerciseList(listURL: "https://www.acefitness.org/education-and-resources/lifestyle/exercise-library/body-part/abs/page/")
        
    }
    
}

