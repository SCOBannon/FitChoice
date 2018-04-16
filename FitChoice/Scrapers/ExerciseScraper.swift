//
//  ExerciseScraper.swift
//  FitChoice
//
//  Created by Sean O'Bannon (student LM) on 4/2/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class ExerciseScraper {
    
    // variables for the exercise
    var name: String? = ""
    var difficulty: String? = ""
    var image: String? = ""
    var steps = [String]()
    
    var view: ExerciseInfoViewController
    
    init(exerciseURL: String, view: ExerciseInfoViewController) {
        self.view = view
        getHTML(urlString: exerciseURL)
    }
    
    // gets the HTML of the url it is passed, and then passes that HTML to parseHTML for parsing
    func getHTML(urlString: String) {
        if let url = URL(string: urlString) {
            let getHTMLTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let html = String(data: data, encoding: .utf8)
                let htmlComponents = html?.components(separatedBy: "<")
                
                self.parseHTML(htmlComponents: htmlComponents)
            }
            getHTMLTask.resume()
        }
        else {
            // url not instantiated
            print("Error gathering exercise information. Please Try Again.")
        }
    }
    
    // parses out the exercise name, difficulty, image, and steps from the HTML it is passed
    func parseHTML(htmlComponents: [String]?) {
        if let htmlComponentsArr = htmlComponents {
            // finding the exercise name
            var nameIndex: Int? = 0
            
            // looking for where the exercise name is in the html (the index)
            for s in htmlComponentsArr {
                if s.contains("class=\"exercise-hero__title\"") {
                    nameIndex = htmlComponentsArr.index(of: s)
                }
            }
            
            // setting the name and cleaning up the string
            if let index = nameIndex {
                name = String(htmlComponentsArr[index].characters.drop(while: { (c) -> Bool in
                    c != ">"
                }))
                name?.characters.popFirst()
                
                // getting rid of "&reg;" if it exists in the string and replacing it with the actual ® character
                if (name?.contains("&reg; "))! {
                    let nameComponents = name?.components(separatedBy: "&reg; ")
                    name = "\(nameComponents![0])® \(nameComponents![1])"
                }
            }
            
            print(name!)
            
            
            // finding the difficulty
            var difficultyIndex: Int? = 0
            
            // looking for where the difficulty is in the html (the index) - this is an approximation, it is not the exact index
            for s in htmlComponentsArr {
                if s.contains("class=\"exercise-info__bar-img\"") {
                    difficultyIndex = htmlComponentsArr.index(of: s)
                }
            }
            
            // actually parsing out the difficulty level
            if var index = difficultyIndex {
                while !(htmlComponentsArr[index].contains("Beginner") || htmlComponentsArr[index].contains("Intermediate") || htmlComponentsArr[index].contains("Advanced")) {
                    index += 1
                }
                difficulty = String(htmlComponentsArr[index].characters.drop(while: { (c) -> Bool in
                    c != ">"
                }))
                difficulty?.characters.popFirst()
            }
            
            //print(difficulty!)
            
            
            // finding the exercise image
            var imageIndex: Int? = 0
            
            // looking for where the exercise image is in the html (the index)
            for s in htmlComponentsArr {
                if s.contains("class=\"exercise-hero__image\"") {
                    imageIndex = htmlComponentsArr.index(of: s)
                }
            }
            
            // setting the exercise image and cleaning up the string
            if let index = imageIndex {
                image = String(htmlComponentsArr[index].characters.drop(while: { (c) -> Bool in
                    c != "'"
                }))
                image?.characters.popFirst()
                
                for i in 0...4{
                    image?.characters.popLast()
                }
            }
            
            //print(image!)
            
            
            // finding the steps
            var startIndex: Int? = 0
            
            // finding where the steps start in the html
            for s in htmlComponentsArr{
                if s.contains("exercise-post") && s.contains("step-content") {
                    startIndex = htmlComponentsArr.index(of: s)
                }
            }
            
            if let start = startIndex {
                // finding where the steps end in the html
                var endIndex = start
                var i = start + 1
                
                while !htmlComponentsArr[i].contains("div>") {
                    endIndex += 1
                    i += 1
                }
                
                // moving the steps from the html to an array
                for i in start...endIndex {
                    steps.append(htmlComponentsArr[i])
                }
                
                // cleaning up the strings in the steps array
                for i in (0...steps.count-1).reversed() {
                    // removing blank space from the back
                    while steps[i].hasSuffix("\n") || steps[i].hasSuffix(" ") {
                        steps[i] = String(steps[i].characters.dropLast())
                    }
                    
                    // removing blank space from the front
                    while steps[i].hasPrefix("\n") || steps[i].hasPrefix(" ") {
                        steps[i] = String(steps[i].characters.dropFirst())
                    }
                    
                    // removing the remains of the HTML tag from the front of the string
                    var stepsSplit = steps[i].components(separatedBy: ">")
                    steps[i] = stepsSplit[stepsSplit.endIndex-1]
                    
                    // removing &nbsp;, &ldquo;, or &rdquo; if the string contains it
                    var badStrings = ["&nbsp;", "&ldquo;", "&rdquo;"]
                    
                    for bS in badStrings {
                        if steps[i].contains(bS) {
                            var stepArr = steps[i].components(separatedBy: bS)
                            steps[i] = ""
                            
                            for s in stepArr {
                                steps[i] += s
                            }
                        }
                    }
                    
                    // removing excess strings (ones that don't contain steps) from the array
                    if (steps[i].contains("/") && steps[i].contains(">")) || (steps[i].contains("&nbsp;") && steps[i].characters.count < 10) || steps[i].hasPrefix("div ") || steps[i].characters.count == 0 || (steps[i].contains("Share:") && steps[i].characters.count == "Share:".characters.count){
                        steps.remove(at: i)
                    }
                }
                
                // checking the steps array to make sure that the steps are in a list, not a paragraph
                var containsSteps: Bool = false
                
                for s in steps {
                    if s.contains("Step 1") {
                        containsSteps = true
                    }
                }
                
                var finalSteps = [String]()
                
                // if the steps are in a list, parse the actual step text out. Otherwise, just put the paragraph in the finalSteps array
                if containsSteps {
                    // transferring the steps into a "finalSteps" array - this contains just the text of the steps, and each step only occupies one index
                    while steps[0] != "Step 1" {
                        steps.remove(at: 0)
                    }
                    
                    let pat = "Step [0-9]"
                    let regex = try! NSRegularExpression(pattern: pat, options: [])
                    
                    var stepNumber = -1
                    
                    // loops through each item in steps to see if it is just the step number (i.e. "Step 1") or the actual text of the step. If it is the step number, creates a new index in finalSteps and increments stepNumber. Otherwise, appends the text of s to finalSteps at the current stepNumber
                    for s in steps {
                        if regex.matches(in: s, options: [], range: NSRange(location: 0, length: s.characters.count)).count > 0 {
                            stepNumber += 1
                            finalSteps.append("")
                        }
                        else {
                            if finalSteps[stepNumber].characters.count != 0 {
                                finalSteps[stepNumber].append("\n")
                            }
                            finalSteps[stepNumber].append(s)
                        }
                    }
                }
                else {
                    finalSteps.append(steps[0])
                }
                
                // Add "step x" to beginning of each step
                for i in 0...finalSteps.count-1 {
                    finalSteps[i] = "Step \(i+1): \(finalSteps[i])\n\n"
                }
                steps = finalSteps
                
                // printing out the steps after all the parsing is done
                for i in 0...finalSteps.count-1 {
                    print("\(i): \(finalSteps[i])")
                }
            }
            else {
                // startIndex not found
                print("Error gathering exercise information. Please Try Again.")
            }
        }
        else {
            // HTML components not parsed
            print("Error gathering exercise information. Please Try Again.")
        }
        DispatchQueue.main.async {
            let imageData:NSData = NSData(contentsOf: URL(string: self.image!)!)!
            let image = UIImage(data: imageData as Data)
            self.view.exerciseImage.image = image
            self.view.exerciseImage.contentMode = UIViewContentMode.scaleAspectFit
            
            self.view.infoLabel.text = self.name
            self.view.infoLabel.adjustsFontSizeToFitWidth = true
            self.view.difficultyLabel.text = self.difficulty
            var stepString = ""
            for step in self.steps {
                stepString+="\(step)"
            }
            while stepString.hasSuffix("\n") || stepString.hasSuffix(" ") {
                stepString = String(stepString.characters.dropLast())
            }
            self.view.stepsView.text = stepString

            return
        }
    }
    
}
