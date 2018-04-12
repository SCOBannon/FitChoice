//
//  ListScraper.swift
//  FitChoice
//
//  Created by Sean O'Bannon (student LM) on 4/2/18.
//  Copyright © 2018 Sean O'Bannon (student LM). All rights reserved.
//

import UIKit

class ListScraper {
    
    // variables for the list
    var exerciseURLComponents: [[String]?] = [[String]?]()
    var exercises: [String: String] = [String: String]()
    var sortedExercises: [String]?
    
    var listTableView: UITableView
    
    init(listURL: String, tableView: UITableView) {
        self.listTableView = tableView
        getOverallComponents(urlString: listURL)
    }
    
    // this function takes a url and parses its HTML, putting that HTML into an array of strings broken up by HTML tag. It then passes that array onto the processOverallPage function
    func getOverallComponents(urlString: String) {
        if let url = URL(string: urlString) {
            let getHTMLTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let generalPageHTML = String(data: data, encoding: .utf8)
                let generalPageComponents = generalPageHTML?.components(separatedBy: "<")
                
                self.processOverallPage(url: url, generalPageComponents: generalPageComponents)
            }
            getHTMLTask.resume()
        }
        else {
            // url not instantiated
            print("Error Getting Exercises. Please Try Again")
        }
    }
    
    // finds the numberOfExercises in the HTML, uses that to calculate the number of pages of exerciese, creates an array of URLs with each URL corresponding to one page of exercises, passes that array to another function that will parse the HTML from the URLs
    func processOverallPage(url: URL, generalPageComponents: [String]?) {
        var startIndex: Int?
        
        if let stringComponentsArr = generalPageComponents {
            // finds the tag in the HTML in which number of exercises is located
            for s in stringComponentsArr{
                if s.contains("script type=\"text/javascript\">") && s.contains("FilterPagination.itemsTotal") {
                    startIndex = stringComponentsArr.index(of: s)
                }
            }
            
            // finding the number of exercises
            if let index = startIndex {
                let numberExerciseStringArr = stringComponentsArr[index].components(separatedBy: " ")
                var numIndex = 0
                
                // finds where in the tag found above the number of exercises is located
                for i in 0...numberExerciseStringArr.count-1{
                    if numberExerciseStringArr[i].contains("FilterPagination.itemsTotal") {
                        numIndex = i + 2
                    }
                }
                
                // parses the number of exercies from the tag
                if let numExercises = Int(numberExerciseStringArr[numIndex].components(separatedBy: ";")[0]) {
                    // calculates the number of pages based off of the number of exercises
                    let numPages: Int = {
                        if numExercises%12 != 0 {
                            return (numExercises/12) + 1
                        }
                        else {
                            return numExercises/12
                        }
                    }()
                    
                    // builds an array of URLs - each URL corresponds to one page of exercises (the array is numPages long, since there are numPages of exercises)
                    var urlArray = [URL]()
                    
                    for i in 1...numPages {
                        if let pageURL = URL(string: "\(url.absoluteString)\(i)") {
                            urlArray.append(pageURL)
                        }
                    }
                    
                    // if all of the URLs have correctly been made, passed the array of URLs onto a function that will parse them
                    if urlArray.count == numPages {
                        getPageComponents(urlArray: urlArray, index: 0, numExercises: numExercises)
                    }
                    else {
                        // one or more URLs were not created
                        print("Error Getting Exercises. Please Try Again")
                    }
                }
                else {
                    // numExercises not parsed
                    print("Error Getting Exercises. Please Try Again")
                }
            }
            else {
                // startIndex not found
                print("Error Getting Exercises. Please Try Again")
            }
        }
        else {
            // stringComponents not parsed
            print("Error Getting Exercises. Please Try Again")
        }
    }
    
    // this function gets passed an array of URLs and gets the HTML for every URL in that array, adding that HTML to a global var. once finished, it calls a function to parse the HTML
    func getPageComponents(urlArray: [URL], index: Int, numExercises: Int) {
        let url = urlArray[index]
        
        let getHTMLTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let pageHTML = String(data: data, encoding: .utf8)
            let pageComponents = pageHTML?.components(separatedBy: "<")
            
            self.exerciseURLComponents.append(pageComponents)
            
            // if all of the URLs have been gathered, move on to parsing them for the exercises, otherwise, parse the HTML of the next URL in the list
            if index+1 == urlArray.count {
                self.processEachPage(numExercises: numExercises)
            }
            else {
                self.getPageComponents(urlArray: urlArray, index: index + 1, numExercises: numExercises)
            }
        }
        getHTMLTask.resume()
    }
    
    // this function reads through all of the HTML in the exerciseURLComponents array and parses out every single exercise name and its corresponding link
    func processEachPage(numExercises: Int) {
        // looping through each page's HTML
        for i in 0...exerciseURLComponents.count-1 {
            if let components = exerciseURLComponents[i] {
                var parseSecondSection = false
                var j = 0
                repeat {
                    // finding where the section starts in the HTML
                    var foundSectionStart = false
                    var sectionIndex: Int?
                    
                    while !foundSectionStart {
                        if components[j].contains("exercise-card-grid exercise-card-grid--3col") {
                            sectionIndex = j
                            foundSectionStart = true
                        }
                        j += 1
                    }
                    
                    // parsing out the exercises from the section
                    if var index = sectionIndex {
                        // setting the amount of exercises that will be added to the array
                        var exercisesToAdd: Int = {
                            // if not on the last page or on the last page but in the first section and the first section has 6
                            if i < exerciseURLComponents.count-1 || (numExercises%12 > 6 && !parseSecondSection){
                                return 6
                            }
                                // on the first section of the final page, and the first section has less than 6
                            else if !parseSecondSection{
                                return numExercises%12
                            }
                                // on the second section of the final page
                            else  {
                                return numExercises%12 - 6
                            }
                        }()
                        
                        var exerciseLink = ""
                        var exerciseName = ""
                        // looping through the HTML and pulling out the names and links of exercises
                        while exercisesToAdd > 0 {
                            // link
                            if components[index].contains("a href=") {
                                exerciseLink = "https://www.acefitness.org\(components[index].components(separatedBy: "\"")[1])"
                            }
                                // name
                            else if components[index].contains("class=\"exercise-card__title\"") {
                                exerciseName = components[index].components(separatedBy: ">")[1]
                                
                                // checks to see if there is already an exercise with the same name in the dictionary. if so, adds a number to the end of the duplicate name so that both can exist as separate keys
                                if exercises.keys.contains(exerciseName) {
                                    exerciseName += " 2"
                                }
                                
                                // getting rid of "&reg;" if it exists in the string and replacing it with the actual ® character
                                if exerciseName.contains("&reg; ") {
                                    let exerciseNameComponents = exerciseName.components(separatedBy: "&reg; ")
                                    exerciseName = "\(exerciseNameComponents[0])® \(exerciseNameComponents[1])"
                                }
                                
                                exercises.updateValue(exerciseLink, forKey: exerciseName)
                                exercisesToAdd -= 1
                            }
                            index += 1
                        }
                        
                        // if just parsed the second section, parseSecondSection=false so that the first section of the next page can be parsed
                        if parseSecondSection == true {
                            parseSecondSection = false
                            j = 0
                        }
                            // if the second section exists on the current page, parse it (exists if not the final page or the final page has more than 6 exercises)
                        else if i < exerciseURLComponents.count-1 || numExercises%12 > 6 {
                            parseSecondSection = true
                        }
                    }
                    else {
                        // sectionIndex not found
                        print("Error Getting Exercises. Please Try Again")
                    }
                    
                } while parseSecondSection  //only repeats if there will be exercises to parse in the second section (i.e. we're not not on the last page or we are and there are more than 6 exercises to parse on the last page). repeats a max of 1 time
            }
            else {
                // components not parsed correctly
                print("Error Getting Exercises. Please Try Again")
            }
        }
        sortedExercises = Array(exercises.keys).sorted()
        DispatchQueue.main.async {
            self.listTableView.reloadData()
            return
        }
        print(numExercises)
        print(exercises.count)
    }
    
}
